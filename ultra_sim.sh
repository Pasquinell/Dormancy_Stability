
#! /bin/bash

for ((N=1;N<=4;N++)); do
	echo $N
	cp job_main *.sh $N/
	cd $N/ &&
##	./make_jobFeno.sh > job_main
	condor_submit job_main_arguments
	cd ../
done
###############
