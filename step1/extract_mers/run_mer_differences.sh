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

mkdir MxM_minus_SxS
cd MxM_minus_SxS ; pwd
ln -s ../MxM/meryl_distinct.db meryl_first.db
ln -s ../SxS/meryl_distinct.db meryl_second.db
${MERYL} difference meryl_first.db meryl_second.db output meryl_diff.db
echo -n $? ; echo " exit status"
meryl statistics meryl_diff.db > difference.stats
cd ..

mkdir SxS_minus_MxM
cd SxS_minus_MxM ; pwd
ln -s ../SxS/meryl_distinct.db meryl_first.db
ln -s ../MxM/meryl_distinct.db meryl_second.db
${MERYL} difference meryl_first.db meryl_second.db output meryl_diff.db
echo -n $? ; echo " exit status"
meryl statistics meryl_diff.db > difference.stats
cd ..

mkdir SxM_intersect_SminusM
cd SxM_intersect_SminusM ; pwd
ln -s ../SxM/meryl_distinct.db meryl_first.db
ln -s ../SxS_minus_MxM/meryl_diff.db meryl_second.db
${MERYL} intersect meryl_first.db meryl_second.db output meryl_intersect.db
echo -n $? ; echo " exit status"
meryl statistics meryl_intersect.db > intersection.stats
cd ..

mkdir SxM_intersect_MminusS
cd SxM_intersect_MminusS ; pwd
ln -s ../SxM/meryl_distinct.db meryl_first.db
ln -s ../MxM_minus_SxS/meryl_diff.db meryl_second.db
${MERYL} intersect meryl_first.db meryl_second.db output meryl_intersect.db
echo -n $? ; echo " exit status"
meryl statistics meryl_intersect.db > intersection.stats
cd ..

mkdir MxS_intersect_SminusM
cd MxS_intersect_SminusM ; pwd
ln -s ../MxS/meryl_distinct.db meryl_first.db
ln -s ../SxS_minus_MxM/meryl_diff.db meryl_second.db
${MERYL} intersect meryl_first.db meryl_second.db output meryl_intersect.db
echo -n $? ; echo " exit status"
meryl statistics meryl_intersect.db > intersection.stats
cd ..

mkdir MxS_intersect_MminusS
cd MxS_intersect_MminusS ; pwd
ln -s ../MxS/meryl_distinct.db meryl_first.db
ln -s ../MxM_minus_SxS/meryl_diff.db meryl_second.db
${MERYL} intersect meryl_first.db meryl_second.db output meryl_intersect.db
echo -n $? ; echo " exit status"
meryl statistics meryl_intersect.db > intersection.stats
cd ..

date
cd .. ; pwd
echo DONE



