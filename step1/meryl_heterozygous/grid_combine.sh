#!/bin/sh

SCRIPT=./run_combine.sh

replicate() {
    REP=$1
    #cd ${REP}
    pwd
    sbatch --account=${ACCOUNT} ${SCRIPT} SxM ${REP} 
    sbatch --account=${ACCOUNT} ${SCRIPT} MxS ${REP} 
    #cd ..
}

replicate "BR1"
replicate "BR2"
replicate "BR3"
replicate "BR4"

