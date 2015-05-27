#!/bin/bash
tail -n +17 $1 &> temp.csv
mv temp.csv $1
sed -i 's/,"0","true"//g' $1
sed -i 's/,"color","pen down?"//g' $1
