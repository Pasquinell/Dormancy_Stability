#!/bin/bash

tipo=$1   # si es l, o, e
proc=$2   # 2010, 2011, etc
hilo=$3   # numero de hilo: 1, 2, etc.

if [ "l" == "$tipo" ]; then
  tip='log'
elif [ "o" == "$tipo" ]; then
  tip='output'
elif [ "e" == "$tipo" ]; then
  tip='error'
fi
 
linea=$(echo "results.$tip.$proc.$hilo")

cat $linea
