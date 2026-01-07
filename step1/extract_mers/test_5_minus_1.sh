#!/bin/sh

#SBATCH --account=${ACCOUNT}
#SBATCH --job-name=merdif
#SBATCH --time=2:00:00   
#SBATCH --mem-per-cpu=4G  
#SBATCH --cpus-per-task=2
set -o errexit # exit on errors

# Require parameter like BR1.
# We will cd to that directory.
# We use existing meryl databases in subdirectories MxM, SxS, MxS, SxM.
# Will create more subdirectories and create meryl databases in them.
# Assume those subdirectories do not already exist.
# Consider using meryl greater-than to ensure first.db has signficantly more than second.db
# For now, we rely on a threshold applied to both databases.

date
echo $0
echo $1

echo "Expect 1 parameter like BR1"
if [[ $# -ne 1 ]] ; then
    echo "Parameters not specified."
    exit 1
fi
cd $1 ; pwd

MERYLDIR=/cluster/home/jasonrm/Source/MerylStableRelease/meryl-1.4.1/bin
MERYL=${MERYLDIR}/meryl

mkdir M5_minus_S1
cd M5_minus_S1 ; pwd
ln -s ../MxM/meryl_distinct.db meryl_first.db
ln -s ../SxS/meryl_all.db      meryl_second.db
${MERYL} difference meryl_first.db meryl_second.db output meryl_diff.db
echo -n $? ; echo " exit status"
meryl statistics meryl_diff.db > difference.stats
cd ..

mkdir S5_minus_M1
cd S5_minus_M1 ; pwd
ln -s ../SxS/meryl_distinct.db meryl_first.db
ln -s ../MxM/meryl_all.db      meryl_second.db
${MERYL} difference meryl_first.db meryl_second.db output meryl_diff.db
echo -n $? ; echo " exit status"
meryl statistics meryl_diff.db > difference.stats
cd ..

