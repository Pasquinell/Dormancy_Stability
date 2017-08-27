#!/bin/bash

if [ "$1" = "1" ]
then
   condor_q pasqui -run
fi
if [ "$1" = "0" ]
then
   condor_q pasqui
fi

if [ "$1" = "2" ]
then
   condor_q  -global -run
fi

if [ "$1" = "3" ]
then
  condor_status
fi

condor_q | tail -n -1 > totales.tmp

err=$(ls results.error.* -l | awk '{if ($5>"0") SUM += 1} END {print SUM}')
log=$(ls results.log.* -l | awk '{SUM1 += $5} END {print SUM1}')
out=$(ls results.output.* -l | awk '{SUM2 += $5} END {print SUM2}')
errc=$(ls results.error.* -l | awk '{SUM3 += $5} END {print SUM3}')

cat totales.tmp
linea="ERRORES: "${err}" LOG: "${log}" OUTPUT: "${out}" ERR ACUM: "${errc}
echo $linea 
echo "."
echo "./b.sh <Opciones>"
echo "0=lista completa; 1=en ejecucion; 2=ejecucion global; 3=estado cluster"
