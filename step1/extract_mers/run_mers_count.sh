#!/bin/sh

#SBATCH --account=${ACCOUNT}
#SBATCH --job-name=mercnt
#SBATCH --time=4:00:00   
#SBATCH --mem-per-cpu=5G  # Some jobs thrashed at 4 cput * 4 GB  
#SBATCH --cpus-per-task=4
set -o errexit # exit on errors

# Do not run this directly.
# Use grid_mers_count to submit this to grid.

date
pwd
echo $0

R1=$1
R2=$2
MERYL=$3
KMERSIZE=$4
THREADS=$5
GREATERTHAN=$6  

echo "Reads R1 and R2..."
ls -l ${R1}
ls -l ${R2}
echo "Command: ${MERYL} k=${KMERSIZE} threads=${THREADS}"
echo "meryl count..."
${MERYL} count k=${KMERSIZE} threads=${THREADS} ${R1} ${R2} output meryl_all.db
echo -n $? ; echo " meryl exit status"
date
echo "meryl filter..."
${MERYL} greater-than ${GREATERTHAN} threads=${THREADS} meryl_all.db output meryl_distinct.db
echo -n $? ; echo " meryl exit status"
date
echo "meryl reports..."
meryl statistics meryl_all.db > all.stats
meryl statistics meryl_distinct.db > distinct.stats
date
echo "DONE"

