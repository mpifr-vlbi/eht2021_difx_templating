#!/usr/bin/python3
# -*- coding: utf-8 -*-
'''
Queries the EHT VLBI monitoring database and lists the pads
that had the reference antenna during EHT VLBI observations.

Usage: vlbimon-get-noemaPosition.py [<track>]

With no arguments, all entries in the database for the
currently known EHT VLBI tracks are printed out.

When a specific track is given, such as e21a17, the
coordinates are shown in VEX $ANTENNA section format.
'''
from __future__ import print_function
import datetime
import sys

from dbSession import dbSession
from ehtTrackList import ehtTrackList
from noemaPadPositions import noemaPadPositions

__author__    = 'Jan Wagner'
__license__   = "LGPL"
__version__   = "1.0.0"
__status__    = "Development"

def list_positions(session, timebracket, trackname, sites, doVex=False):

	noemapads = noemaPadPositions()

	fields = ['phasing_referencePad', 'phasing_referenceAntennaID', 'phasing_numberOfAntennas', 'phasing_antennaIDs']
	ss = session.fetch_timeseries(timebracket, sites, fields)

	count = 0
	for sitename, val in ss.items():
		states, keyname, uxtime = session.make_state_series(val)
		for (t,values) in zip(uxtime,states):
			phasedIDs, numphased, refantID, padname = values
			vlbipos = noemapads.getPadCoordsECEF(padname)
			tpretty = datetime.datetime.utcfromtimestamp(int(t))
			if doVex:
				if count==0:
					print('     site_position = %.4f m : %.4f m : %.4f m;   * %s pad %s, %s phased' % (vlbipos[0],vlbipos[1],vlbipos[2],trackname,padname,numphased))
				else:
					print('     * site_position = %.4f m : %.4f m : %.4f m; * %s pad %s, %s phased' % (vlbipos[0],vlbipos[1],vlbipos[2],trackname,padname,numphased))
			else:
				print('Track %s : time bracket %s : %s %s %s' % (trackname,str(timebracket),str(tpretty),str(values),str(vlbipos)))
			count += 1


def main():

	dbsession = dbSession()
	ehtTracks = ehtTrackList()
	sites = ['NOEMA']

	tracks = ehtTracks.listTracks()
	doVex = False

	if len(sys.argv) >= 2:

		usertracks = []
		for track in sys.argv[1:]:
			if track not in tracks:
				print('Error: Requested track %s unknown by Class ehtTrackList (currently known: %s). ' % (track,' '.join(tracks)))
				sys.exit(1)
			usertracks += [track]
		tracks = usertracks
		doVex = True

	if doVex:
		print('def NOEMA;')
		print('     site_name = NOEMA;')
		print('     site_ID = Nn;')
		print('     site_type = fixed;')
		print('     site_velocity =  0.0 m/yr : 0.0 m/yr : 0.0 m/yr;')
		print('     site_position_epoch = 0;')

	for track in tracks:
		timebracket = ehtTracks.getTrackTimerange(track)
		list_positions(dbsession, timebracket, track, sites, doVex)

	if doVex:
		print('enddef;')


if __name__ == '__main__':
    main()

# vim: foldmethod=indent
