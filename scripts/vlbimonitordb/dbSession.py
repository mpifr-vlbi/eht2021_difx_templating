#!/usr/bin/python3
# -*- coding: utf-8 -*-
'''
Wrapper for HTTPS session to EHT VLBI Monitor data base (vlbimon1.science.ru.nl).
Derived from 'report-module-stream.py' demo written by Andre Young.

Authentication for HTTPS is entered by the user manually into the terminal,
or is read from a local config file if present (~/.ehtmon_database.conf).

Example config file:

[vlbimon1]
User = John Smith
Password = Smith
'''

from __future__ import print_function
import datetime, calendar
import configparser, pathlib
import requests

__author__    = 'Jan Wagner, Andre Young'
__license__   = "LGPL"
__version__   = "1.0.0"
__status__    = "Development"

SUBDOMAIN   = 'vlbimon1'
SERVER_URL  = 'https://%s.science.ru.nl' % SUBDOMAIN
FNAME       = '.sessionid.%s.txt' % SUBDOMAIN
USER_CONFIG = '~/.ehtmon_database.conf'

class dbSession:

    def __init__(self, configfile: str = USER_CONFIG):

        # Get HTTPS auth User and Password to use for the hard coded subdomain
        config = configparser.ConfigParser()
        config.optionxform = lambda option: option                   # preserve case for letters
        configfullpath = pathlib.PosixPath(configfile).expanduser()  # turn ~ into a full path, since Python ConfigParser doesn't cope with ~/<file>
        config.read(configfullpath)
        if SUBDOMAIN in config.sections() and all(key in ['User','Password'] for (key,value) in config.items(SUBDOMAIN)):
            self.username = config[SUBDOMAIN].get('User')
            self.password = config[SUBDOMAIN].get('Password')
        else:
            print('Config file %s not found, or lacks section [%s] with both User and Password' % (USER_CONFIG,SUBDOMAIN))
            import getpass
            self.username = input("User: ")
            self.password = getpass.getpass("Password for {:}: ".format(self.username))

        # Open a HTTPS session
        self.sess = requests.Session()
        self.open_session()


    '''Setup user session with server'''
    def __restore_session(self):

        #-- read from file
        with open(FNAME, 'r') as f:
            sessionid = f.readline().strip()

        #-- validate
        self.sess.cookies.set('sessionid', sessionid)
        url = SERVER_URL + '/session/' + sessionid
        r = self.sess.patch(url)
        r.raise_for_status()


    '''Setup new user session with server'''
    def __create_session(self):
        url = SERVER_URL + '/session'

        r = self.sess.post(url, auth=requests.auth.HTTPBasicAuth(self.username, self.password))
        r.raise_for_status()
        resp = r.json()
        sessionid = resp['id']
        self.sess.cookies.set('sessionid', sessionid)

        #-- write to file
        with open(FNAME, 'w') as f:
            f.write(sessionid)

    '''Open user session with server'''
    def open_session(self):
        #-- restore session
        try:
            self.__restore_session()
        except: pass  # makes no sense? but is in original code like this...
        #-- create new session if restore failed
        self.__create_session()


    '''Fetch metadata timeseries data from server'''
    def fetch_timeseries(self, timebracket, sites=[], fields=[]):
        url = SERVER_URL + '/data/history'

        tail = ['observatory=' + s for s in sites]
        tail += ['field=' + f for f in fields]
        tail += ['startTime=%d' % timebracket[0], 'endTime=%d' % timebracket[1]]
        if len(tail) > 0:
            url += '?' + '&'.join(tail)

        r = self.sess.get(url)
        r.raise_for_status()
        return r.json()

    '''Turn a parallel timeseries into sequence of states'''
    def make_state_series(self, d):
        ks = list(d.keys())

        xs = []
        for k in ks:
            for v in d[k]: xs.append(v[0])
        #-- uniq sort
        xs = list(set(xs))
        xs.sort()

        state = len(ks) * [None]
        states = []
        for x in xs:
            #n = 0
            for i, k in enumerate(ks):
                if len(d[k]) == 0: continue
                if d[k][0][0] < x:
                    #print(k, d[k][0], x)
                    #print('WARNING: duplicate time stamps in data: dropping later points')
                    continue
                if d[k][0][0] > x: continue
                #-- this point updates the state now
                v = d[k].pop(0)
                state[i] = v[1]
                #n += 1
            states.append(list(state))
            ##-- all drawn down
            #if n == 0: break

        return states, ks, xs

# vim: foldmethod=indent
