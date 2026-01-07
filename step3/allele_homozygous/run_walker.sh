#!/bin/sh

python --version
date

MERYLDIR=../meryl_homozygous
SALMONDIR=../salmon_homozygous

function walk() {
    echo "$1.pat..."
    python read_walker.py ${MERYLDIR}/${1}.pat.IDs.txt.gz ${SALMONDIR}/${1}.read_gene.tsv.gz ${1}.pat.gene_counts.tsv
    echo "$1.mat..."
    python read_walker.py ${MERYLDIR}/${1}.mat.IDs.txt.gz ${SALMONDIR}/${1}.read_gene.tsv.gz ${1}.mat.gene_counts.tsv
    date
    echo "done"
}    

walk SxS_BR1
walk SxS_BR2
walk SxS_BR3
walk SxS_BR4

walk MxM_BR1
walk MxM_BR2
walk MxM_BR3
walk MxM_BR4

echo DONE
