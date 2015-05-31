#!/bin/bash

CMD="./degreePlotter.R "

#getting the plot name and other stuff
OUT=`echo $1 | cut -d'_' -f 1,2`
NODES=`echo $1 | cut -d'_' -f 3`
MAX_DEGREE=`echo $1 | cut -d'_' -f 5`
YLABEL=`echo $1 | cut -d'_' -f 1 | sed 's/[a-z,A-Z,\.]*mockup\///' | sed 's/[a-z,A-Z,\.]*plots\///'`
XLABEL=Time
HEADING=`echo $OUT|sed 's/_/ /'| sed  's/[a-z,A-Z,\.]*mockup\///'|sed 's/[a-z,A-Z,\.]*plots\///'`
OUT=`echo $OUT".pdf"| sed  's/[a-z,A-Z,\.]*mockup\///'|sed 's/[a-z,A-Z,\.]*plots\///'`

CMD=$CMD$1" "$OUT" "$XLABEL" "$YLABEL" "$HEADING" "$NODES" "$MAX_DEGREE

OTHER_TESTS=`ls $(echo $1 | cut -d'_' -f 1,2)*.csv`
for j in $OTHER_TESTS
do
   if [ $1 != $j ]
   then
      NODES=`echo $j | cut -d'_' -f 3`
      MAX_DEGREE=`echo $j | cut -d'_' -f 5`
      CMD=$CMD" "$j" "$NODES" "$MAX_DEGREE
   fi
done

for k in $2 $3 $4
do
   NODES=`echo $k | cut -d'_' -f 3`
   MAX_DEGREE=`echo $k | cut -d'_' -f 5`
   OUT=`echo $k | cut -d'_' -f 1,2`
   OUT=$OUT".eps"
   HEADING=`echo $OUT|sed 's/.eps//'|sed 's/[a-z,A-Z,\.]*mockup\///'|sed 's/[a-z,A-Z,\.]*plots\///'|sed 's/_/ /'`
   CMD=$CMD" "$k" "$HEADING" "$NODES" "$MAX_DEGREE

   OTHER_TESTS=`ls $(echo $k | cut -d'_' -f 1,2)*.csv`
   for l in $OTHER_TESTS
   do
      if [ $k != $l ]
      then
         NODES=`echo $l | cut -d'_' -f 3`
         MAX_DEGREE=`echo $l | cut -d'_' -f 5`
         CMD=$CMD" "$l" "$NODES" "$MAX_DEGREE
      fi
   done
done

echo "plotting..."
$CMD #&> /dev/null
echo "DONE!"

#removing unneeded files
rm Rplots.pdf &> /dev/null
