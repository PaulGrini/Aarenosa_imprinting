#!/bin/sh

repeat() {
    REP=$1
    JOB="SxS_${REP}"
    sbatch --account=${ACCOUNT} ./run_salmon.sh ${JOB} 
    JOB="MxM_${REP}"
    sbatch --account=${ACCOUNT} ./run_salmon.sh ${JOB} 
}

repeat "BR1"
repeat "BR2"
repeat "BR3"
repeat "BR4"

