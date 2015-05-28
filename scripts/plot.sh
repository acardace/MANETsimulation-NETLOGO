#!/bin/bash

CMD="./plotter.R "

#cleaning files
#for i in $1 $2 $3 $4
#do
##   tail -n +17 $i &> temp.csv
   #mv temp.csv $i
   #sed -i 's/,"0","true"//g' $i
   #sed -i 's/,"color","pen down?"//g' $i
   #sed -i 's/"//g' $i
#done

#getting the plot name and other stuff
OUT=`echo $1 | cut -d'_' -f 1,2`
OUT=\"$OUT".eps"\"
YLABEL=\"`echo $1 | cut -d'_' -f 1 | sed  's/[a-z,A-Z,\.]*mockup\///' | sed 's/[a-z,A-Z,\.]*plots\///'`\"
XLABEL=\"Time\"
HEADING=`echo $OUT|sed 's/.eps//'|sed 's/_/ /'| sed  's/[a-z,A-Z,\.]*mockup\///'|sed 's/[a-z,A-Z,\.]*plots\///'`

CMD=$CMD$1" "$OUT" "$XLABEL" "$YLABEL" "$HEADING

for k in $2 $3 $4
do
   CMD=$CMD" "$k
   OUT=`echo $k | cut -d'_' -f 1,2`
   OUT=\"$OUT".eps"\"
   HEADING=`echo $OUT|sed 's/.eps//'|sed 's/_/ /'| sed  's/[a-z,A-Z,\.]*mockup\///'|sed 's/[a-z,A-Z,\.]*plots\///'`
   CMD=$CMD" "$HEADING
done

echo $CMD
