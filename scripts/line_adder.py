#!/usr/bin/python

#script to add missing lines in Degree csv files

import sys
import os
import math

f = open(sys.argv[1], 'r')
content = f.read()
f.close()
content = content.split('\n')

i = 1
counter = 0
while i < len(content[1:]):
    elem = int( content[i][:content[i].index(',')] )
    if elem != counter:
        content.insert(i, str(counter) + ",0")
    i = i+1
    counter = counter +1
    if counter==26:
        counter = 0

i=1
for s in content[1: (math.floor(len(content)/2))]:
    elem = int( s[:s.index(',')] )
    value = int( s[s.index(',')+1:] )
    toadd = int( content[i+26][content[i+26].index(',') + 1 :] )
    content[i] = str(elem) + "," + str(int( (value + toadd) / 2))
    i+=1

f = open(sys.argv[1], "w")

for s in content[:(math.floor(len(content)/2))]:
    f.write(str(s) + "\n")

f.close()
