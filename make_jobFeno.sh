#!/bin/bash

echo "#Created by make_jobFeno.sh"
echo "getenv = true"
echo "universe=vanilla"
echo "executable=./run_main.sh"
echo 'output=results.output.$(Cluster).$(Process)'
echo 'error=results.error.$(Cluster).$(Process)'
echo 'log=results.log.$(Cluster).$(Process)'

for v1 in  1 
    do
    for v2 in 0  
        do
        for v3 in 1 
            do
            echo "arguments=" $v1 $v2 $v3
            echo "queue"
        done
     done
done
