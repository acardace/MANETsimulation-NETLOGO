#!/usr/bin/python

#script to add missing lines in Degree csv files

import sys
import os
import math

os.rename(sys.argv[1], ".tmp.csv")

f = open(".tmp.csv",'r')
new_f = open(sys.argv[1], 'w')

content = f.read()
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
    print("sub "+str(s)+" with "+str(content[i]))
    i+=1

for s in content[:(math.floor(len(content)/2))]:
    new_f.write(str(s) + "\n")

f.close()
new_f.close()
os.unlink(".tmp.csv")
