#!/usr/bin/python
'''
Usage: tvex2vex.py [-I<includePath>] vexfile.tvex [<output.vex>]

Generates a new file 'vexfile.vex' from the template 'vexfile.tvex'
by expanding "*include <filename>" or "#include <filename>" directives
in the template. After this expansion pass, the generated output is checked
for any "*loaddata <datafile>" directives and VEX data fields are populated
or replaced using data from the referenced data files.

The format of a $CLOCK-populating data file is
   line 1: CLOCK
   line 2: <stationName> <ref_time for delay> <delay> <ref_time for rate> <rate>
   line 3: <stationName> <ref_time for delay> <delay> <ref_time for rate> <rate>
   ...
Other formats are not added yet.

(C) 2019 Jan Wagner, Max Planck Institute for Radio Astronomy
'''

import os, re, sys
from optparse import OptionParser

__author__="Jan Wagner <jwagner@mpifr-bonn.mpg.de>"
__prog__ = os.path.basename(__file__)
__build__= "$Revision: 8798 $"
__date__ ="$Date: 2019-03-13 09:20:08 +0100 (Wed, 13 Mar 2019) $"
__lastAuthor__="$Author: JanWagner $"


def loadFileLines(filename):
    lines = []
    try:
        with open(filename, 'r') as f:
            lines = f.readlines()
    except:
        pass
    return lines


def storeFileLines(filename, lines):
    with open(filename, 'w') as f:
        f.writelines(lines)


def findIncludeFile(filename, includepaths):
    '''
    Try to locate filename under all includepaths.
    Return full file&path, or None if not found.
    '''
    for inc in includepaths:
       fqpn = '%s/%s' % (inc,filename)
       if os.path.isfile(fqpn):
           return fqpn
    return None


def isComment(line):
    '''
    :return True if line is a comment or empty
    '''
    L = line.strip()
    return ( (len(L) < 1) or (L[0] == '*') or (L[0] == '#'))


def expandIncludes(lines, includepaths):
    '''
    Go through list of 'lines' and expand all '*include<>' or '#include<>' statements.
    '''
    expanded = []

    # Regexp for '*include<>' with arbitrary preceding '*#' and whitespace:
    # test: sline='***  include  < testfile> '; g=reInclude.search(sline); print(g.groups())
    reInclude = re.compile( r'[#*]+\s*include\s*[<]+\s*(.*)\s*[>]+' )

    # Copy all lines, expand any includes
    for line in lines:

        if not isComment(line):
            expanded.append(line[:])
            continue

        sline = line.strip()
        incStatement = reInclude.search(sline)
        if incStatement:
            filename = incStatement.group(1)
            incfile = findIncludeFile(filename, includepaths)
            if incfile == None:
                print ('Error: could not find included file %s!' % (filename))
                print ('Statement: %s' % (sline))
                print ('Include paths: %s' % (str(includepaths)))
                sys.exit(1)
            if options.verbose:
                print ('Expanding on "%s" using "%s"' % (sline,incfile))
            insertable = loadFileLines(incfile)
            expanded += insertable
        else:
            expanded.append(line[:])

    return expanded


def populateData_Clock(lines, data):
    '''
    Update VEX entries with CLOCK data
    '''

    # Load data
    clks = []
    ants = []
    for d in data:
        d = d.strip()
        if isComment(d):
            continue
        (antenna,delay,rate) = d.split()  # todo: try/except?
        clk = {'antenna':antenna, 'delay':delay, 'rate':rate}
        clks.append(clk)
        ants.append(antenna)

    # Update VEX
    for n in range(1,len(lines)):

        line = lines[n]
        if isComment(line):
            continue

        # Remember recent 'def <something>;' regardless of block type (CLOCK, ANTENNA, ...)
        if ('def ' in line):
            antDef = lines[n].strip()
        elif ('def ' in lines[n-1]):
            antDef = lines[n-1].strip()
        else:
            # no 'def', or multiple clock-early
            continue

        if 'clock_early' not in line:
            continue

        # Handle clock for this antenna?
        i1 = antDef.find('def ');
        i2 = antDef.find(';', i1)
        currAnt = antDef[i1:i2].split()[1]
        if currAnt not in ants:
            if options.verbose:
                print ('Skip: antenna %s not among updateable antennas in data file' % (currAnt))
            continue

        clk = clks[ants.index(currAnt)]
        if (currAnt != clk['antenna']):
            print("Programmer oops in populateData_Clock(): antenna list index didn't match tuple index of antenna")
            sys.exit(1)

	# Break up clock_early, update it
        i1 = line.find('clock_early')
        i2 = line.find('=', i1)
        i3 = line.find(';', i2)
        oldClk = line[(i2+1):i3].replace(':', ' ')
        oldClk = oldClk.replace('usec', ' ')
        oldClkRest = line[i3:]
        vals = oldClk.split() # [VexTime, delay, VexTime, rate, <leftovers>]
        newClk = 'clock_early = %s : %s usec : %s : %s' % (vals[0],clk['delay'],vals[2],clk['rate'])

        # Replace with new clock line
        lines[n] = line[:i1] + newClk + oldClkRest

    return lines


def populateData(lines, includepaths):
    '''
    Go through list of 'lines' and look for '*loaddata<>' statements,
    invoke the respective data loader according to data type
    specified in the file.
    '''
    updated = []
    supported_datatypes = ['CLOCK']

    # Regexp for '*loaddata<>' with arbitrary preceding '*#' and whitespace:
    reLoad = re.compile( r'[#*]+\s*loaddata\s*[<]+\s*(.*)\s*[>]+' )

    # Check all lines, find all loaddata directives, remove them
    loadFiles = []
    for line in lines:
        loadStatement = reLoad.search(line)
        if loadStatement:
            datafile = loadStatement.group(1)
            incfile = findIncludeFile(datafile, includepaths)
            if incfile == None:
                print ('Error: could not find included file %s!' % (datafile))
                print ('Statement: %s' % (line))
                print ('Include paths: %s' % (str(includepaths)))
                sys.exit(1)
            loadFiles.append(incfile)
            if options.verbose:
                print ('Updating upon "%s" using "%s"' % (line.strip(),incfile))
        else:
            updated.append(line[:])

    # Process the loaddata files
    for file in loadFiles:

        print file
        data = []
        with open(file, 'r') as df:
            data = df.readlines()

        if len(data) < 2:
            print ('Bad data file %s: too short' % (file))
            sys.exit(1)

        datatype = data[0].strip()
        data = data[1:]

        supported = datatype in supported_datatypes
        if not supported:
            print ('Bad data file %s: unsupported type %s' % (file,datatype))
            sys.exit(1)

        if datatype == 'CLOCK':
            updated = populateData_Clock(updated, data)

    return updated


def generateVex(tvexfile, includepaths, vexname=None):
    '''
    Load and parse template vex file.
    '''

    # Load and process
    tvex = loadFileLines(tvexfile)
    vex = expandIncludes(tvex, options.includepaths)
    vex = populateData(vex, options.includepaths)

    # Output to console or to file
    if (vexname == None):
        for line in vex:
            print(line.rstrip())
    else:
        storeFileLines(vexname, vex)
        print ('Wrote results into %s' % (vexname))


if __name__ == "__main__":

    parser = OptionParser(version=__build__, usage=__doc__)
    parser.add_option('-v', '--verbose', dest='verbose', action='store_true')
    parser.add_option('-I', '--include', dest='includepaths', action='append', type='str')
    (options, args) = parser.parse_args()

    if len(args) < 1:
        print(__doc__)
        sys.exit(0)

    tvexfile = args[0]
    vexoutname = None
    if len(args) > 1:
        vexoutname = args[1]

    vex = generateVex(tvexfile, options.includepaths, vexoutname)
