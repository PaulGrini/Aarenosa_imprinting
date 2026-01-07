#!/bin/sh

# PARAMETER ORDER: 1=counts for the maternal parent, 2=counts for the paternal parent, 3=output

SCRIPT=format_for_stats.py

function stats() {
    REPLICATE=$1

    echo "format SxM"
    MAT=SxM_${REPLICATE}.mat.gene_counts.tsv
    PAT=SxM_${REPLICATE}.pat.gene_counts.tsv
    MNAME="SS"
    PNAME="MM"
    python ${SCRIPT} ${MAT} ${PAT} ${MNAME} ${PNAME} SxM_${REPLICATE}.tsv
    
    echo "format MxS"
    MAT=MxS_${REPLICATE}.mat.gene_counts.tsv
    PAT=MxS_${REPLICATE}.pat.gene_counts.tsv 
    MNAME="MM"
    PNAME="SS"
    python ${SCRIPT} ${MAT} ${PAT} ${MNAME} ${PNAME} MxS_${REPLICATE}.tsv
}

date
stats BR1
stats BR2
stats BR3
stats BR4
date
echo DONE
