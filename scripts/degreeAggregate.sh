#!/bin/bash

#delete all whitespaces
rename ' ' '-'  $1/[Degree]*.csv
echo "whitespaces removed..."

FILES=`ls $1/*.csv | grep 'Degree'`
echo "doing append operations..."

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

      #add empty values to file
      LASTELEM=`cat $i| tail -n 1| cut -d',' -f 1`
      LASTELEM=`echo $((LASTELEM+1))`
      for j in `seq $LASTELEM 25`; do
         echo "$j,0" >> $i
      done

      #fill holes
      ./line_adder.py $i

      OUT=`echo $i | sed 's/_[0-9]*.csv/\*.csv/' | sed 's/\.\///g'`
      SAMEFILES=`ls $OUT| sed 's/\.\///g'`

      #renaming main file
      MAINFILE=`echo $SAMEFILES | cut -d' ' -f 1`

      #test the name if there is a double _5_5_
      echo  $i | grep _5_5_ &> /dev/null
      if [ $? -eq 0 ]
      then
         mv $MAINFILE `echo $MAINFILE | sed 's/_5_5_[0-9].*\.csv/_5_5\.csv/'`
         MAINFILE=`echo $MAINFILE | sed 's/_5_5_[0-9].*\.csv/_5_5\.csv/'`
      else
         mv $MAINFILE `echo $MAINFILE | sed 's/_5_[0-9].*\.csv/_5\.csv/'`
         MAINFILE=`echo $MAINFILE | sed 's/_5_[0-9].*\.csv/_5\.csv/'`
      fi

      echo "adding to "$MAINFILE

      SAMEFILES=`echo $SAMEFILES | cut -d' ' -f 2`
      for k in $SAMEFILES
      do
         # fix csv format
         tail -n +17 $k &> temp.csv
         mv temp.csv $k
         sed -i 's/,"0","true"//g' $k
         sed -i 's/,"color","pen down?"//g' $k
         sed -i 's/"//g' $k

         #add empty values to file
         LASTELEM=`cat $k| tail -n 1| cut -d',' -f 1`
         LASTELEM=`echo $((LASTELEM+1))`
         for j in `seq $LASTELEM 25`; do
            echo "$j,0" >> $k
         done

         #fill holes
         ./line_adder.py $k

         # append the content of the file to the first one
         tail -n +2 $k >> $MAINFILE
         rm $k
      done
   fi
done
