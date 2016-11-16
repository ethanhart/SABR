#!/usr/bin/env python
# encoding: utf-8

# Brute force method for determining the minimum number of ABs needed to
# achieve a given BA

from sys import argv

ba = float(argv[1])
ab = 1
n = 5
answers = []
print 'To achieve a BA of {0}:'.format(ba)
while True:
    for i in range(ab):
        hits = i + 1
        tmp_ba = round(hits / float(ab), 3)
        if tmp_ba == ba:
            answers.append('{0} hits needed in {1} ABs'.format(hits, ab))
            if len(answers) == n:
                for ans in answers:
                    print ans
                exit()
            break
    ab += 1
