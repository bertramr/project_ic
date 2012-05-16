#!/usr/bin/env zsh
#BSUB -J "project_ic" 
#BSUB -o '/rwthfs/rz/cluster/work/rb570596/ProjectIC/matlab/output/logs/project_ic.txt'
#BSUB -u reinhold.bertram@rwth-aachen.de
#BSUB -N 
#BSUB -W 3:00
#BSUB -n 8
#BSUB -M 4096

#BSUB -a openmp

module load MISC
module load matlab
cd $WORK/ProjectIC/matlab


# start non-interactive batch job
if [[ -z ${LSB_DJOB_NUMPROC} || ${LSB_DJOB_NUMPROC} -le 1 ]]; then
	# serial case ( with #BSUB -n 1 )
	matlabcmd="matlab -singleCompThread"
else
	# parallel
	mytasks=${LSB_DJOB_NUMPROC}
	let mytasks-=1
	matlabcmd="taskset -c 0-$mytasks matlab"
fi

$matlabcmd -nodisplay -nodesktop -nosplash -logfile job.log <<EOF
if getenv('LSB_DJOB_NUMPROC') > '1' matlabpool('OPEN','local',getenv('LSB_DJOB_NUMPROC')); end

main
exit
EOF
