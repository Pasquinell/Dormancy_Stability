#!/bin/bash
echo "#Created by make_jobFeno.sh"
echo "getenv = true"
echo "universe=vanilla"
echo "executable=./run_main.sh"
echo 'output=./out/results.output.$(Cluster).$(Process)'
echo 'error=./error/results.error.$(Cluster).$(Process)'
echo 'log=./log/results.log.$(Cluster).$(Process)'


c=$1   # conectancia. Asi abro 5 hilos de trabajo.
r=$2   # riqueza.

for c in $c; do #0.1 0.15 0.2 0.25 0.3; do
  for r in $r; do #20 40 60 80 100; do
    for varbif in 0; do
      for vv1 in 0 1; do
        for vv2 in 2; do
          for vv3 in 1 2; do
            for EPDP in 0 0.25 0.5 0.75 1; do
              for fenoR in 1 2; do
                for fenoD in 1 2; do
                  if [ "$fenoR" -eq "$fenoD" ]; then
                  for matrices in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do
                    for replicas in 1 2 3 4 5 6 7 8 9 10; do
                       semilla=$(($RANDOM*10))
                       if [ "$semilla" -eq "0" ]; then semilla=$(($RANDOM*10)); fi
                       echo "arguments= " $c $r $varbif $vv1 $vv2 $vv3 $EPDP $fenoR $fenoD $matrices $replicas $semilla
                       echo "queue"
                    done
                  done
                  fi
                done
              done
            done
          done
        done
      done
    done
  done
done
