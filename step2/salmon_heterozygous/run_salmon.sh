#!/bin/sh
#SBATCH --account=${ACCOUNT}
#SBATCH --job-name=salmon
#SBATCH --time=4:00:00   # about 1 hour for Salmon on Arenosa plus 1 hour sam to bam
#SBATCH --mem-per-cpu=4G  
#SBATCH --cpus-per-task=4  
set -o errexit # exit on errors
#savefile *.bam

echo "run_salmon.sh $1"
date
# expect a job name like SxM_BR1
JOB=$1
echo "Job ${JOB}"

module load GCC/11.3.0
module load SAMtools/1.16.1-GCC-11.3.0

RDIR=/cluster/projects/nn9525k/hybrids/jasonrm/Arenosa/IRP_run/Trimmed
R1="${RDIR}/${JOB}_R1_trim.fq.gz"
R2="${RDIR}/${JOB}_R2_trim.fq.gz"
INDEX=Aa_nodecoy_auto
echo "Salmon index $INDEX"
LIBTYPE="A"   # type=innie/outie etc, A= inferred automatically
echo "libType ${LIBTYPE}"

echo "Run salmon"
./salmon quant -i ${INDEX} --libType ${LIBTYPE} -1 ${R1} -2 ${R2} \
	  --threads 4 --writeMappings=${JOB}.sam --validateMappings -o ${JOB}
echo "$? salmon exit status"
date

echo "sam to bam"
samtools view -b ${JOB}.sam > ${JOB}.bam
echo "$? samtoos exit status"
echo "OK to delete sam files and just keep their bam versions"

ls -l ${JOB}.sam ${JOB}.bam

echo done
