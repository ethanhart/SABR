#!/usr/bin/env python
# encoding: utf-8

import requests
from bs4 import BeautifulSoup
import urlparse
#from sys import argv
#import argparse
#import re
import json
import time
import os

# Download team information from baseball-reference
# A lot of calls made to the site, so try to run at
# night. Data is downloaded on a per-city basis to
# avoid having to rerun to frequently.


def parse_site(url):
    """Get the webpage, return the html tree"""

    page = requests.get(url)
    content =  page.content
    soup = BeautifulSoup(content)
    return soup


def parse_city(soup):
    """From a city page, parse the table
    to get team names, leagues, levels, years
    """

    table = soup.find('table', attrs={'class': 'stats_table'})
    #print table
    body = table.find('tbody')
    trs = body.find_all('tr')
    all_teams = []
    for team in trs:
        tds = team.find_all('td')
        year = tds[0].text
        league = tds[1].text
        level = tds[2].text
        team = tds[3].text
        #print team
        info = {"team_name": team, "level": level, "league": league, "year": year}
        all_teams.append(info)

    return all_teams


def main():
    br_cities = "http://www.baseball-reference.com/register/team.cgi"
    soup = parse_site(br_cities)
    #with open('./team_citys.txt') as br:
        #soup = BeautifulSoup(br.read())

    tables = soup.find_all('table', attrs={'class': 'small_text'})
    teams = {}
    for table in tables:
        tds = table.find_all('td')
        for td in tds:
            a = td.find('a')
            if a:
                href = a['href']
                city_url = 'http://www.baseball-reference.com' + href
                parsed_url = urlparse.urlparse(city_url)
                qs = urlparse.parse_qs(parsed_url.query)
                if 'city' in qs:
                    city_str = qs['city'][0]
                    if 'country' in qs:
                        country_str = qs['country'][0]
                    else:
                        country_str = 'NONE'
                    if 'state' in qs:
                        state_str = qs['state'][0]
                    else:
                        state_str = 'NONE'
                    location = '{0}_{1}_{2}'.format(city_str, state_str, country_str)
                    location_file = location + '.json'
                    if not os.path.exists('team_data/{0}'.format(location_file)):
                        print location
                        city_soup = parse_site(city_url)
                        city_team_data = parse_city(city_soup)
                        with open('team_data/{0}'.format(location_file), 'w') as jsono:
                            jsono.write(json.dumps(city_team_data, separators=(',', ':'), indent=4, encoding="utf-8"))
                        time.sleep(5)
                    else:
                        print '{0} already exists!'.format(location)


if __name__ == "__main__":
    main()
