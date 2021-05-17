#!/bin/bash
#
# Split sections of the VEX files under ../observed_vex/ into different files.
#

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
VEXDIR=../observed_vex/
OUTDIR=../templates/common_sections/

pushd $SCRIPT_DIR

function extract_vex_sections() {

	vexname=`basename $1`

	# Get all of SCHED block until end of file
	sed -n "/\$SCHED;/,/^<eof>/p" $1 > $OUTDIR/sched_$vexname

	# Get all of SOURCE block until FREQ block
	sed -n "/\$SOURCE;/,/\$FREQ;/p" $1 > $OUTDIR/sources_$vexname
	sed -i '$ d' $OUTDIR/sources_$vexname  # remove trailing $FREQ; line

	# Remove LMT from SCHED block:
	# - LMT did not observe EHT2021, yet is in the scheduled-triggered VEX files.
	# - Remove the station to avoid an issue in DiFX vex2difx ("Developer error: VexData::hasData: cannot find antenna LM")
	sed -i "s/station\=Lm/\*\*station\=Lm/g" $OUTDIR/sched_$vexname
}

for vexfile in `ls -1 $VEXDIR/*.vex`; do
	echo "Running extract_vex_sections $vexfile"
	extract_vex_sections $vexfile
done

