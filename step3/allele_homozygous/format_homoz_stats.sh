#!/bin/sh

# PARAMETER ORDER: 1=counts for the true "parent", 2=counts for the false "parent", 3=output

SCRIPT=format_for_stats.py

function stats() {
    REPLICATE=$1

    echo "format SS"
    TRUE=SxS_${REPLICATE}.mat.gene_counts.tsv
    FALSE=SxS_${REPLICATE}.pat.gene_counts.tsv
    TNAME="SS"
    FNAME="MM"
    python ${SCRIPT} ${TRUE} ${FALSE} ${TNAME} ${FNAME} SxS_${REPLICATE}.tsv
    
    echo "format MM"
    TRUE=MxM_${REPLICATE}.mat.gene_counts.tsv
    FALSE=MxM_${REPLICATE}.pat.gene_counts.tsv
    TNAME="MM"
    FNAME="SS"
    python ${SCRIPT} ${TRUE} ${FALSE} ${TNAME} ${FNAME} MxM_${REPLICATE}.tsv
}

date
stats BR1
stats BR2
stats BR3
stats BR4
date
echo DONE
