#!/usr/bin/env python
# encoding: utf-8

# Brute force method for determining the minimum number of ABs needed to
# achieve a given BA

from sys import argv

ba = float(argv[1])  # 0 < ba > 1.000
n = 5  # number of results
answers = []
ab = 1
while len(answers) < n:  # test until we have n answers
    for i in range(ab):  # for each ab, test each case (e.g. 1/3, 2/3, 3/3)
        hits = i + 1
        tmp_ba = round(hits / float(ab), 3)  # batting average to check
        if tmp_ba == ba:
            answers.append('{0} hits needed in {1} ABs'.format(hits, ab))
    ab += 1

# print results
print 'To achieve a BA of {0}:'.format(ba)
for ans in answers:
    print ans
