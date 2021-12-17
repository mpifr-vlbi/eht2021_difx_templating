#!/usr/bin/python3
# -*- coding: utf-8 -*-
'''
A list of EHT tracks for each year, and their time ranges.
Time ranges are converted from VEX format into gmtime.
These can be used in VLBImonitor server API queries.

TODO:
 - does Daan have any description of the actual database, which tables exist?
   would there be a table to query for year, returning track names, track dates?
 - or keep adding EHT track infos manually into this module?
'''

from __future__ import print_function
import datetime, calendar
from typing import List

__author__    = 'Jan Wagner'
__license__   = "LGPL"
__version__   = "1.0.0"
__status__    = "Development"

class ehtTrackList:

	def __init__(self, year: int = -1):

		self.tracks = {}
		# e21b09.vex: exper_nominal_start=2021y098d23h52m00s; exper_nominal_stop=2021y099d15h23m00s;
		# e21e13.vex: exper_nominal_start=2021y102d19h40m00s; exper_nominal_stop=2021y103d11h40m00s;
		# e21a14.vex: exper_nominal_start=2021y103d23h40m00s; exper_nominal_stop=2021y104d15h50m00s;
		# e21d15.vex: exper_nominal_start=2021y104d23h29m00s; exper_nominal_stop=2021y105d15h42m00s;
		# e21a16.vex: exper_nominal_start=2021y105d23h32m00s; exper_nominal_stop=2021y106d15h02m00s;
		# e21a17.vex: exper_nominal_start=2021y106d23h28m00s; exper_nominal_stop=2021y107d15h38m00s;
		# e21e18.vex: exper_nominal_start=2021y107d19h20m00s; exper_nominal_stop=2021y108d11h49m00s;
		# e21f19.vex: exper_nominal_start=2021y109d01h13m00s; exper_nominal_stop=2021y109d06h08m00s;
		#
		# e18c21.vex: exper_nominal_start=2018y110d22h38m00s; exper_nominal_stop=2018y111d14h36m00s;
		# e18e22.vex: exper_nominal_start=2018y111d22h31m00s; exper_nominal_stop=2018y112d14h36m00s;
		# e18a24.vex: exper_nominal_start=2018y114d03h02m00s; exper_nominal_stop=2018y114d15h45m00s;
		# e18c25.vex: exper_nominal_start=2018y114d22h22m00s; exper_nominal_stop=2018y115d14h20m00s;
		# e18g27.vex: exper_nominal_start=2018y116d19h30m00s; exper_nominal_stop=2018y117d09h33m00s;
		# e18d28.vex: exper_nominal_start=2018y117d21h57m00s; exper_nominal_stop=2018y118d09h39m00s;
		#
		# e17d05.vex: exper_nominal_start=2017y094d22h31m00s; exper_nominal_stop=2017y095d17h07m00s;
		# e17b06.vex: exper_nominal_start=2017y096d00h46m00s; exper_nominal_stop=2017y096d16h14m00s;
		# e17c07.vex: exper_nominal_start=2017y097d04h01m00s; exper_nominal_stop=2017y097d20h42m00s;
		# e17a10.vex: exper_nominal_start=2017y099d23h17m00s; exper_nominal_stop=2017y100d15h10m00s;
		# e17e11.vex: exper_nominal_start=2017y100d22h16m00s; exper_nominal_stop=2017y101d15h22m00s;
		#
		self.tracks['e21b09'] = ['exper_nominal_start=2021y098d23h52m00s;', 'exper_nominal_stop=2021y099d15h23m00s;']
		self.tracks['e21e13'] = ['exper_nominal_start=2021y102d19h40m00s;', 'exper_nominal_stop=2021y103d11h40m00s;']
		self.tracks['e21a14'] = ['exper_nominal_start=2021y103d23h40m00s;', 'exper_nominal_stop=2021y104d15h50m00s;']
		self.tracks['e21d15'] = ['exper_nominal_start=2021y104d23h29m00s;', 'exper_nominal_stop=2021y105d15h42m00s;']
		self.tracks['e21a16'] = ['exper_nominal_start=2021y105d23h32m00s;', 'exper_nominal_stop=2021y106d15h02m00s;']
		self.tracks['e21a17'] = ['exper_nominal_start=2021y106d23h28m00s;', 'exper_nominal_stop=2021y107d15h38m00s;']
		self.tracks['e21e18'] = ['exper_nominal_start=2021y107d19h20m00s;', 'exper_nominal_stop=2021y108d11h49m00s;']
		self.tracks['e21f19'] = ['exper_nominal_start=2021y109d01h13m00s;', 'exper_nominal_stop=2021y109d06h08m00s;']
		#
		self.tracks['e18c21'] = ['exper_nominal_start=2018y110d22h38m00s;', 'exper_nominal_stop=2018y111d14h36m00s;']
		self.tracks['e18e22'] = ['exper_nominal_start=2018y111d22h31m00s;', 'exper_nominal_stop=2018y112d14h36m00s;']
		self.tracks['e18a24'] = ['exper_nominal_start=2018y114d03h02m00s;', 'exper_nominal_stop=2018y114d15h45m00s;']
		self.tracks['e18c25'] = ['exper_nominal_start=2018y114d22h22m00s;', 'exper_nominal_stop=2018y115d14h20m00s;']
		self.tracks['e18g27'] = ['exper_nominal_start=2018y116d19h30m00s;', 'exper_nominal_stop=2018y117d09h33m00s;']
		self.tracks['e18d28'] = ['exper_nominal_start=2018y117d21h57m00s;', 'exper_nominal_stop=2018y118d09h39m00s;']
		#
		self.tracks['e17d05'] = ['exper_nominal_start=2017y094d22h31m00s;', 'exper_nominal_stop=2017y095d17h07m00s;']
		self.tracks['e17b06'] = ['exper_nominal_start=2017y096d00h46m00s;', 'exper_nominal_stop=2017y096d16h14m00s;']
		self.tracks['e17c07'] = ['exper_nominal_start=2017y097d04h01m00s;', 'exper_nominal_stop=2017y097d20h42m00s;']
		self.tracks['e17a10'] = ['exper_nominal_start=2017y099d23h17m00s;', 'exper_nominal_stop=2017y100d15h10m00s;']
		self.tracks['e17e11'] = ['exper_nominal_start=2017y100d22h16m00s;', 'exper_nominal_stop=2017y101d15h22m00s;']


	def listTracks(self, year: int = -1) -> List[str]:

		tracklist = []

		if year==2021 or year<=0:
			tracklist += ['e21b09', 'e21e13', 'e21a14', 'e21d15', 'e21a16', 'e21a17', 'e21e18', 'e21f19']
		if year==2018 or year<=0:
			tracklist += ['e18c21', 'e18e22', 'e18a24', 'e18c25', 'e18g27', 'e18d28']
		if year==2017 or year <=0:
			tracklist += ['e17d05', 'e17b06', 'e17c07', 'e17a10', 'e17e11']

		return tracklist


	def getTrackTimerange(self, trackname: str):

		if trackname not in self.tracks.keys():
			return None

		t0, t1 = self.tracks[trackname]
		gmt0 = self.getGMTimeFromVEXTime(t0)
		gmt1 = self.getGMTimeFromVEXTime(t1)
		timebracket = [gmt0, gmt1]

		return timebracket


	def getGMTimeFromVEXTime(self, t: str):

		t = t.split('=')[1]
		year, doy, hour, mins = int(t[0:4]), int(t[5:8]), int(t[9:11]), int(t[12:14])
		tt = datetime.datetime(year, 1, 1) + datetime.timedelta(days=doy-1) + datetime.timedelta(seconds=60*(60*hour + mins))
		gmt = calendar.timegm(tt.timetuple())

		return gmt
