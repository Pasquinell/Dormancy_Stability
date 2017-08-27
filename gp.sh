#!/bin/bash

for c in $1; do
  for r in 60; do
    for varbif in 1; do
      for vv1 in 0; do
        for vv2 in 2; do
          for vv3 in 1; do
            for EPDP in 1; do
              for fenoR in 1 2 3 4 5; do
                for fenoD in 1 2 3 4 5; do
                  for matrices in $(seq 1 15); do
                    for replicas in $(seq 11 15); do
                       echo $c
                       echo $r
                       echo $varbif
                       echo $vv1
                       echo $vv2
                       echo $vv3
                       echo $EPDP
                       echo $fenoR
                       echo $fenoD
                       echo $matrices
                       echo $replicas
                    done
                  done
                done
              done
            done
          done
        done
      done
    done
  done
done
