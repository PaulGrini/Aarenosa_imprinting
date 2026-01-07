#!/bin/sh

#SBATCH --account=nn9525k
#SBATCH --job-name=Prep&Stats
#SBATCH --time=04:00:00
#SBATCH --mem-per-cpu=4G  # 16 GB total
#SBATCH --cpus-per-task=4  # 4 cpu is optimal for 4 threads

ACCOUNT=nn9525k

# Purpose:
# Use homozygous sequencing to decide which genes are non-performant.
# For example, a gene that generates no reads should not be included in adjusted P-value computation.
# Or, a gene whose reads map to the wrong parent should not be used at all.

# Input:
# The model.tsv assigns each file of counts to a sample and replicate.
# This will help us filter by replicates per sample.

# Ouput:
# Three counts for each gene:
#    min reads in any one replicate
#    min reads in any one sequencing sample (some replicates were sequenced twice)
#    fold change defined as (true-false)/false where 1 is the minimum false value
#    i.e. 500 reads to true parent and 1 to false parent is about 500 fold
#    (but 5 reads to true parent and 0 to false parent is (5-1)/1= 4 fold)

# Set up your python environment first.
SRC="."

echo "Write counts to *.tsv ..."

python3 ${SRC}/filter_homozygous.py main.model.tsv    >    main.min_and_fold.tsv

echo "Write genes to *.genes_pass_filter ..."
echo "Filter for min fold change ..."
# Use c to skip the header line

cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($4>=10)) print $1;}' >   fold10.genes_pass_filter
cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($4>=5)) print $1;}' >    fold05.genes_pass_filter
cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($4>=3)) print $1;}' >    Kfold03.genes_pass_filter
cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($4>=2)) print $1;}' >    fold02.genes_pass_filter
#cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($4>=1)) print $1;}' >    Kfold01.genes_pass_filter

cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($2>=5) && ($4>=5)) print $1;}' >   min5.min20.fold5.genes_pass_filter #column 2 in main.min_and_fold.tsv is the replicate with fewest reads. filtering on this replicate gives genes with at least XX number of reads in each replicate. Filtering on column 3 ($3) filters on the total number of reads for each gene per replicate.
cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($2>=10) && ($4>=5)) print $1;}' >    min10.min40.fold05.genes_pass_filter
cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($2>=15) && ($4>=5)) print $1;}' >    min15.min60.fold05.genes_pass_filter
cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($2>=20) && ($4>=5)) print $1;}' >    min20.min80.fold05.genes_pass_filter
# cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($2>=10) && ($4>=1)) print $1;}' >    min40fold05.genes_pass_filter

#cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($3>=20) && ($4>=5)) print $1;}' >   min20.fold05.genes_pass_filter #column 2 in main.min_and_fold.tsv is the replicate with fewest reads. filtering on th
#cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($3>=40) && ($4>=5)) print $1;}' >   min40.fold05.genes_pass_filter
#cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($3>=60) && ($4>=5)) print $1;}' >   min60.fold05.genes_pass_filter
#cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($3>=80) && ($4>=5)) print $1;}' >   min80.fold05.genes_pass_filter
#cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($3>=30) && ($4>=5)) print $1;}' >   min30.fold05.genes_pass_filter
#cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($3>=50) && ($4>=5)) print $1;}' >   min50.fold05.genes_pass_filter

# cat    main.min_and_fold.tsv | awk '{if ((c++ >0) && ($2>=10) && ($4>=1)) print $1;}' >    min40fold05.genes_pass_filter
