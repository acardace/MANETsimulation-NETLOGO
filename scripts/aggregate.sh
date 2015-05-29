#!/bin/bash
FILES=`ls $1/*.csv`
LASTFILES=" "
for i in $FILES
do
   if [ -e `echo $i | sed 's/\.\///g'` ]
   then
      # fix csv format
      tail -n +17 $i &> temp.csv
      mv temp.csv $i
      sed -i 's/,"0","true"//g' $i
      sed -i 's/,"color","pen down?"//g' $i
      sed -i 's/"//g' $i

      OUT=`echo $i | sed 's/_[0-9]*.csv/\*.csv/' | sed 's/\.\///g'`
      SAMEFILES=`ls $1"/"$OUT| sed 's/\.\///g'`
      for k in `echo $SAMEFILES | cut -d' ' -f 2,3`
      do
         # fix csv format
         tail -n +17 $k &> temp.csv
         mv temp.csv $k
         sed -i 's/,"0","true"//g' $k
         sed -i 's/,"color","pen down?"//g' $k
         sed -i 's/"//g' $k

         # append the content of the file to the first one
         cat $k | tail -n +2 >> `echo $SAMEFILES | cut -d' ' -f 1`
         rm $k
      done
   fi
done
