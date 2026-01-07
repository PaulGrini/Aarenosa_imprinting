#!/bin/sh

python --version
date

MERYLDIR=../meryl_heterozygous
SALMONDIR=../salmon_heterozygous

function walk() {
    echo "$1.pat..."
    python read_walker.py ${MERYLDIR}/${1}.pat.IDs.txt.gz ${SALMONDIR}/${1}.read_gene.tsv.gz ${1}.pat.gene_counts.tsv
    echo "$1.mat..."
    python read_walker.py ${MERYLDIR}/${1}.mat.IDs.txt.gz ${SALMONDIR}/${1}.read_gene.tsv.gz ${1}.mat.gene_counts.tsv
    date
    echo "done"
}    

#walk SxM_BR1
#walk SxM_BR2
#walk SxM_BR3
#walk SxM_BR4

walk MxS_BR1
walk MxS_BR2
walk MxS_BR3
walk MxS_BR4

echo DONE
