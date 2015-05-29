#!/bin/bash

CMD="./plotter.R "

#getting the plot name and other stuff
OUT=`echo $1 | cut -d'_' -f 1,2`
YLABEL=`echo $1 | cut -d'_' -f 1 | sed  's/[a-z,A-Z,\.]*mockup\///' | sed 's/[a-z,A-Z,\.]*plots\///'`
XLABEL=Time
HEADING=`echo $OUT|sed 's/_/ /'| sed  's/[a-z,A-Z,\.]*mockup\///'|sed 's/[a-z,A-Z,\.]*plots\///'`
OUT=`echo $OUT".eps"| sed  's/[a-z,A-Z,\.]*mockup\///'|sed 's/[a-z,A-Z,\.]*plots\///'`

CMD=$CMD$1" "$OUT" "$XLABEL" "$YLABEL" "$HEADING

for k in $2 $3 $4
do
   CMD=$CMD" "$k
   OUT=`echo $k | cut -d'_' -f 1,2`
   OUT=$OUT".eps"
   HEADING=`echo $OUT|sed 's/.eps//'|sed 's/[a-z,A-Z,\.]*mockup\///'|sed 's/[a-z,A-Z,\.]*plots\///'|sed 's/_/ /'`
   CMD=$CMD" "$HEADING
done

echo "plotting..."
$CMD &> /dev/null
echo "DONE!"

#removin unneeded files
rm Rplots.pdf
