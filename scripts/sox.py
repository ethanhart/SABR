#!/usr/bin/env python
# encoding: utf-8

import json
from glob import glob
from sys import argv

# Extract teams from downloaded data
# Additoinal/more complex manipulation
# can be done with this script as the
# starting point.


def extract_teams(data):
    teams = {}
    for entry in data:
        team_name = entry["team_name"]
        league = entry["league"]
        level = entry["level"]
        year = entry["year"]

        if team_name not in teams:
            teams[team_name] = {"leagues": {league: {level: {"years": [year]}}}}
            #stint = {"league": league, "level": level, "years": [year]}
        elif team_name in teams:
            if league in teams[team_name]["leagues"]:
                if level in teams[team_name]["leagues"][league]:
                    teams[team_name]["leagues"][league][level]["years"].append(year)
                else:
                    teams[team_name]["leagues"][league][level] = {"years": [year]}
            else:
                teams[team_name]["leagues"][league] = {level: {"years": [year]}}

    return teams


def main():
    files = argv[1:]
    all_cities = []
    for f in files:
        with open(f) as inf:
            data = json.load(inf)
        city_data = extract_teams(data)
        all_cities.append(city_data)
    for c in all_cities:
        for team in c:
            if 'sox' in team.lower():
            #if 'socks' in team.lower():
            #if 'stocking' in team.lower():
                leagues = len(c[team]["leagues"])
                for _ in range(leagues):
                    print team


if __name__ == "__main__":
    main()
