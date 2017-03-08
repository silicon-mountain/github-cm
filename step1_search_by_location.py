#!/usr/bin/env python
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 nu

import os
import json
import logging
import copy

import requests


from requests.auth import HTTPBasicAuth


countries = json.load(open('africa_data.json'))
logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.DEBUG)

GITHUB_TOKEN = os.environ.get('GITHUB_TOKEN')

output = 'step1.json'
oneMinute = 60
oneHour = oneMinute * 60
minRemainingToStop = 30
reqs = 0
reqsLimit = None
reqsRemaining = None
headers = {}
TOKEN_AUTH = HTTPBasicAuth(GITHUB_TOKEN, "x-oauth-basic")


allUsers = []


def addTo(searchTerm, allUsers, countryStub, city=None):

    def usersFrom(location):
        complete = False
        page = 1
        users = []
        order = 'asc'
        while not complete:
            if page > 10:
                # well, we can't query anymore.
                if order == 'desc':
                    complete = True
                    continue
                order = 'desc'
                page = 1
            req = requests.get(
                'https://api.github.com/legacy/user/search/location:%s' %
                location,
                headers=headers, params={'start_page': page,
                                         'sort': 'joined',
                                         'order': order},
                auth=TOKEN_AUTH)
            page += 1
            try:
                jsusers = json.loads(req.content).get('users')
                if not len(jsusers):
                    complete = True
                    continue
                users += jsusers
            except:
                logger.warning("Failed to parse JSON:")
                logger.warning(req.content)
                complete = True

        return users

    jsonUsers = usersFrom(searchTerm)

    if not len(jsonUsers):
        return

    for user in jsonUsers:
        logger.info("FOUND -- %s -- %s" % (user.get('username'),
                                           user.get('location')))
        user.update({'country': countryStub,
                     'city': city})
        allUsers.append(user)

for countryCode, country in countries.items():
    logger.info("COUNTRY: %s" % country.get('name'))

    countryStub = copy.copy(country)
    countryStub.update({'code': countryCode})
    del(countryStub['patterns'])

    for city in country.get('patterns', []):
        logging.info("SEARCHING for city -- %s" % city.get('name'))
        for searchName in city.get('patterns', [city.get('name')]):
            addTo(searchName, allUsers, countryStub, city)

    for name in country.get('names', []):
        logging.info("SEARCHING for country -- %s" % name)
        addTo(name, allUsers, countryStub, None)

logger.info("Found %d records" % len(allUsers))

json.dump(allUsers, open(output, 'w'), indent=4)

logger.info("UNIQUE user accounts: %d" %
            len(list(set([u.get('username') for u in allUsers]))))
