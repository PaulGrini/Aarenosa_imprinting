#!/bin/sh

# The minus order must be maternal paternal.

SCRIPT=./run_lookup_hetero.sh

replicate() {
    REP=$1
    #cd ${REP}
    pwd
    sbatch --account=${ACCOUNT} ${SCRIPT} SxM ${REP} R1 SxM_intersect_SminusM SxM_intersect_MminusS
    sbatch --account=${ACCOUNT} ${SCRIPT} SxM ${REP} R2 SxM_intersect_SminusM SxM_intersect_MminusS
    sbatch --account=${ACCOUNT} ${SCRIPT} MxS ${REP} R1 MxS_intersect_MminusS MxS_intersect_SminusM
    sbatch --account=${ACCOUNT} ${SCRIPT} MxS ${REP} R2 MxS_intersect_MminusS MxS_intersect_SminusM
    #cd ..
}

replicate "BR1"
replicate "BR2"
replicate "BR3"
replicate "BR4" 

