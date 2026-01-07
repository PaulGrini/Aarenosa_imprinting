#!/bin/sh

repeat() {
    REP=$1
    JOB="SxM_${REP}"
    sbatch --account=${ACCOUNT} ./run_salmon.sh ${JOB} 
    JOB="MxS_${REP}"
    sbatch --account=${ACCOUNT} ./run_salmon.sh ${JOB} 
}

repeat "BR1"
repeat "BR2"
repeat "BR3"
repeat "BR4"

