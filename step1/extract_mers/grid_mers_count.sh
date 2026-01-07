#!/bin/sh

# Create meryl databases of k-mers seen in reads.
# Expect parameter like BR1.
# This will create and populate a BR1 subdirectory of current directory.
# This will submit 4 jobs to the grid.

date
pwd
echo $0

echo "Expect 1 parameter like BR1"
if [[ $# -ne 1 ]] ; then
    echo "Parameters not specified."
    exit 1
fi
REPLICATE=$1
echo "Replicate ${REPLICATE}"

echo MODULES
#module --force purge
#module load StdEnv 
#module load GCC/11.3.0

# Downloaded binaries from the latest release = 25 Sep 2023
MERYLDIR=/cluster/home/jasonrm/Source/MerylStableRelease/meryl-1.4.1/bin
MERYL=${MERYLDIR}/meryl
LOOKUP=${MERYLDIR}/meryl-lookup
KMERSIZE=15
THREADS=4
GREATERTHAN=4  # Counts drop in half between 1,2,3,4 then drop slowly; see all.stats
READSDIR=/cluster/projects/nn9525k/hybrids/jasonrm/Arenosa/Trimming/reads_combined
RUNSCRIPT=../../run_mers_count.sh

function extract () {
    CROSS=$1
    mkdir ${CROSS}
    cd ${CROSS}
    pwd
    R1=${READSDIR}/${CROSS}_${REPLICATE}_R1_trim.fq.gz
    R2=${READSDIR}/${CROSS}_${REPLICATE}_R2_trim.fq.gz
    echo "Reads R1 and R2..."
    ls -l ${R1}
    ls -l ${R2}
    echo "Script..."
    ls -l ${RUNSCRIPT}
    sbatch --account=${ACCOUNT} ${RUNSCRIPT} $R1 $R2 $MERYL $KMERSIZE $THREADS $GREATERTHAN
    cd ..
}

mkdir ${REPLICATE}
cd ${REPLICATE}
extract "MxM"
extract "SxS"
extract "MxS"
extract "SxM"
cd ..

echo "DONE"
