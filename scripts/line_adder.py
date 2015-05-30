#!/usr/bin/python

#script to add missing lines in Degree csv files

import sys
import os

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

for s in content[:-1]:
    new_f.write(str(s) + "\n")

f.close()
new_f.close()
os.unlink(".tmp.csv")
