#!/bin/sh

SCRIPT=./make_fasta.sh

replicate() {
    REP=$1
    #cd ${REP}
    pwd
    sbatch --account=${ACCOUNT} ${SCRIPT} SxS_${REP} 
    sbatch --account=${ACCOUNT} ${SCRIPT} MxM_${REP} 
    #cd ..
}

replicate "BR1"
replicate "BR2"
replicate "BR3"
replicate "BR4"

