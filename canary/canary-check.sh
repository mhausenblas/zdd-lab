#!/bin/bash 

COUNTER=0
ENDPOINT=$1
INVOCATIONS="${2:-10}"
RESULTFILE=simpleservice.result

if [ -f $RESULTFILE ]; then
  rm $RESULTFILE
fi

while [  $COUNTER -lt $INVOCATIONS ]; do
  echo Invoking simpleservice: $COUNTER
  let COUNTER=COUNTER+1 
  curl -s $ENDPOINT:10099/endpoint0 >> $RESULTFILE
  echo "" >> $RESULTFILE
  sleep .1
done

NUM_v09=`cat $RESULTFILE | grep \"0.9 | wc -l`
NUM_v10=`cat $RESULTFILE | grep \"1.0 | wc -l`

echo Out of $INVOCATIONS clients of simpleservice $NUM_v09 saw version 0.9 and $NUM_v10 saw version 1.0