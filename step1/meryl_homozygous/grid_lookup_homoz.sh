#!/bin/sh

# The minus order must be maternal paternal.

SCRIPT=./run_lookup_homoz.sh

replicate() {
    REP=$1
    #cd ${REP}
    pwd
    sbatch --account=${ACCOUNT} ${SCRIPT} SxS ${REP} R1 SxS_minus_MxM MxM_minus_SxS
    sbatch --account=${ACCOUNT} ${SCRIPT} SxS ${REP} R2 SxS_minus_MxM MxM_minus_SxS
    sbatch --account=${ACCOUNT} ${SCRIPT} MxM ${REP} R1 MxM_minus_SxS SxS_minus_MxM
    sbatch --account=${ACCOUNT} ${SCRIPT} MxM ${REP} R2 MxM_minus_SxS SxS_minus_MxM
    #cd ..
}

replicate "BR1"
replicate "BR2"
replicate "BR3"
replicate "BR4" 

