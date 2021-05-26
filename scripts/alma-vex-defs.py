#!/usr/bin/python3
'''
ALMA VEX helper tool

Script to manufacture VEX entries for use with ALMA data.
Sky frequencies of filterbank channels are derived from 1st LO
and 2nd LO information. Channels are always 62.5 MHz wide.

Functionality is much reduced from EHTC alma-vex-defs.py, but
outputs copy-paste-able VEX and v2d sections, unlike the single
polarization EHTC alma-vex-defs.py script.
'''

import argparse
import sys

__author__ = "Jan Wagner (MPIfR)"
__version__ = "1.0.0"

ALMA_PFB_BANDWIDTH_MHZ = 62.5
ALMA_PFB_CHANNEL_DELTA_MHZ = 58.59375  # = 62.5 * 15/16


def parse_args(args: []):

	cmd='%(prog)s <options>'

	parser = argparse.ArgumentParser(description=__doc__, add_help=True, formatter_class=argparse.RawDescriptionHelpFormatter)
	parser.add_argument('--version', action='version', version='%(prog)s ' + __version__)
	parser.add_argument('-f', '--lo1', dest='lo1', metavar='GHz', default='221.100', help='frequency of 1st LO (EHT 221.100; default: %(default)s)')
	parser.add_argument('-F', '--lo2', dest='lo2', metavar='GHz', default='1.875', help='frequency of 2nd LO (default: %(default)s)')
	parser.add_argument('-r', dest='recorders', default='1,2,3,4', help='list of recorder ID numbers (default: %(default)s)')
	parser.add_argument('--if', '-i', dest='do_vex_if', action='store_true', help='also output VEX $IF section')
	parser.add_argument('--bbc', '-b', dest='do_vex_bbc', action='store_true', help='also output VEX $BBC section')
	# todo? : parser.add_argument('--v2d', '-v', dest='do_v2d', action='store_true', help='also output v2d ANTENNA, DATASTREAM sections')

	return parser.parse_args(args)


class BandLabel:
	'''Helper class to assign labels to frequency ranges'''

	def __init__(self, name='b1', fstart_GHz=212.053, fstop_GHz=214.100):
		self.name = name
		if fstart_GHz > fstop_GHz:
			fstart_GHz,fstop_GHz = fstop_GHz,fstart_GHz
		self.fstart_GHz = fstart_GHz
		self.fstop_GHz = fstop_GHz

	def isContained(self, freq_GHz):
		return freq_GHz >= self.fstart_GHz and freq_GHz <= self.fstop_GHz

	def getName(self):
		return self.name


class EHTBandLabels:
	'''Definitions of EHT frequency "bands"'''

	def __init__(self):
		self.bands = [
			BandLabel('b1',212.052,214.100),
			BandLabel('b2',214.100,216.148),
			BandLabel('b3',226.052,228.100),
			BandLabel('b4',228.100,230.148),
			BandLabel('b1_0.8mm',334.552,336.600),
			BandLabel('b2_0.8mm',336.600,338.648),
			BandLabel('b3_0.8mm',346.552,348.600),
			BandLabel('b4_0.8mm',348.600,350.648)
		]

	def lookUp(self, freq_GHz, sideband='U'):
		labels = []
		if 'U' in sideband.upper():
			f0,f1 = freq_GHz, freq_GHz + ALMA_PFB_BANDWIDTH_MHZ*1e-3
		else:
			f0,f1 = freq_GHz - ALMA_PFB_BANDWIDTH_MHZ*1e-3, freq_GHz
		for band in self.bands:
			if band.isContained(f0) or band.isContained(f1):
				labels.append(band.getName())
		full_labels = ','.join(labels)
		return full_labels


class ALMAVexFreqGenerator:
	'''
	VEX frequency block generator
	'''

	def __init__(self, bandlabels=EHTBandLabels()):
		self.lo1_GHz, self.lo2_GHz = 0, 0
		self.recorders = []
		self.bw_MHz = ALMA_PFB_BANDWIDTH_MHZ
		self.step_MHz = ALMA_PFB_CHANNEL_DELTA_MHZ
		self.pol2bbcnr = {'R':1, 'L':2, 'H':1, 'V':2, 'X':1, 'Y':2}
		self.indent = '   '
		self.bandlabels = bandlabels
		self.nvexchannels = 0


	def __generate_block(self, pfb_center_GHz, netUsb=True, subbands=range(32)):
		'''
		fxUsb: True if net upper sideband USB
		subbands: PFB subband indices for which to compute the VEX channel frequencies
		'''
		lo_sign = +1
		label = 'U' # 'U' for USB
		if not netUsb:
			lo_sign = -1
			label = 'L'

		refFreq_MHz = 1e3*pfb_center_GHz - lo_sign*(1e3*(self.lo2_GHz/2) + (self.bw_MHz/32))

		channels = []
		for subband in subbands:
			edge_freq = refFreq_MHz + lo_sign*subband*self.step_MHz
			channels.append([edge_freq, label])

		return channels


	def __print_chan_def(self, freq_MHz, sideband, chNr, pollabel, bandlabel):

		bbc = self.pol2bbcnr[pollabel]
		if len(bandlabel) < 1:
			print('%schan_def = &B: %.6f MHz : %1s : %.2f MHz : &CH%02d : &BBC%02d : &NoCal;' % (self.indent, freq_MHz, sideband, self.bw_MHz, chNr, bbc))
		else:
			print('%schan_def = &B: %.6f MHz : %1s : %.2f MHz : &CH%02d : &BBC%02d : &NoCal; * %s' % (self.indent, freq_MHz, sideband, self.bw_MHz, chNr, bbc, bandlabel))


	def generate(self, lo1_GHz, lo2_GHz=1.875, recorders=[1,2,3,4]):

		def subblock(pfb_center_GHz, usb, subbands, polzn):
			channelblock = self.__generate_block(pfb_center_GHz, netUsb=usb, subbands=subbands)
			for idx,(freq_MHz,sideband) in enumerate(channelblock):
				bandlabel = self.bandlabels.lookUp(freq_MHz*1e-3,sideband)
				bandlabel += ' ' + polzn
				self.__print_chan_def(freq_MHz, sideband, idx + self.nvexchannels, polzn, bandlabel)
			self.nvexchannels += len(subbands)

		self.lo1_GHz, self.lo2_GHz = lo1_GHz, lo2_GHz
		self.nvexchannels = 1

		print('def FREQ_AA; * derived for on lo1=%.3f lo2=%.3f GHz' % (lo1_GHz, lo2_GHz))
		print('%ssample_rate = %.1f Ms/sec;  * (2bits/sample)' % (self.indent, 2*self.bw_MHz))

		if 1 in recorders:

			print('%s* Recorder 1, slots 1+2, LSB around LO1-8 GHz, X-pol, subbands 0-31' % (self.indent))
			subblock(lo1_GHz - 8.0, False, range(32), 'X')
			print('%s* Recorder 1, slots 3+4, LSB around LO1-8 GHz, Y-pol, subbands 0-31' % (self.indent))
			subblock(lo1_GHz - 8.0, False, range(32), 'Y')

		if 2 in recorders:

			print('%s* Recorder 2, slots 1+2, LSB around LO1-6 GHz, X-pol, subbands 0-31' % (self.indent))
			subblock(lo1_GHz - 6.0, False, range(32), 'X')
			print('%s* Recorder 2, slots 3+4, LSB around LO1-6 GHz, Y-pol, subbands 0-31' % (self.indent))
			subblock(lo1_GHz - 6.0, False, range(32), 'Y')

		if 3 in recorders:

			print('%s* Recorder 3, slots 1+2, USB around LO1 + 6 GHz, X-pol, subbands 0-31' % (self.indent))
			subblock(lo1_GHz + 6.0, True, range(32), 'X')
			print('%s* Recorder 3, slots 3+4, USB around LO1 + 6 GHz, Y-pol, subbands 0-31' % (self.indent))
			subblock(lo1_GHz + 6.0, True, range(32), 'Y')

		if 4 in recorders:

			print('%s* Recorder 4, slots 1+2, USB around LO1 + 8 GHz, X-pol, subbands 0-31' % (self.indent))
			subblock(lo1_GHz + 8.0, True, range(32), 'Y')
			print('%s* Recorder 4, slots 3+4, USB around LO1 + 8 GHz, Y-pol, subbands 0-31' % (self.indent))
			subblock(lo1_GHz + 8.0, True, range(32), 'Y')

		print('enddef;')


	def generateIF(self, lo1_GHz=None):

		ref_lo = 85.5

		if lo1_GHz is not None and lo1_GHz > 0:
			ref_lo = lo1_GHz
		elif self.lo1_GHz is not None and self.lo1_GHz > 0:
			ref_lo = self.lo1_GHz

		print('')
		print('$IF;')
		print('def IF_AA; * station Aa')
		print('    if_def = &IF_X : A1 : X : %.2f MHz : U ;' % (ref_lo*1e3))
		print('    if_def = &IF_Y : B1 : Y : %.2f MHz : U ;' % (ref_lo*1e3))
		print('enddef;')


	def generateBBC(self):

		print('')
		print('$BBC;')
		print('def BBC_AA; * station Aa')
		print('    BBC_assign = &BBC01 :  1 : &IF_X;')
		print('    BBC_assign = &BBC02 :  1 : &IF_Y;')
		print('enddef;')



if __name__ == "__main__":

	opts = parse_args(sys.argv[1:])
	lo1 = float(opts.lo1)
	lo2 = float(opts.lo2)
	recorders = [int(recNr) for recNr in opts.recorders.split(',')]

	if lo2 > lo1:
		print('Error: LO2 (-F %.3f GHz) should not be greater than LO1 (-f %.3f GHz)!' % (lo2, lo1))
		sys.exit(1)

	labels = EHTBandLabels()
	gen = ALMAVexFreqGenerator(labels)
	gen.generate(lo1, lo2, recorders)

	if opts.do_vex_if:
		gen.generateIF()
	if opts.do_vex_bbc:
		gen.generateBBC()
