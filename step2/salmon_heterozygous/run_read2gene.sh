#!/bin/sh

#!/bin/sh
#SBATCH --account=${ACCOUNT}
#SBATCH --job-name=read2gene
#SBATCH --time=2:00:00   
#SBATCH --mem-per-cpu=4G  
#SBATCH --cpus-per-task=1  
set -o errexit # exit on errors
#savefile *.tsv

# Use samtools flag 67 to keep only: read paired, pair mapped proper, first in pair.
# Sort the outputs by read ID.
# Must use unix sort (not samtools sort) to match our MER-based outputs.

date
echo $1
mkdir ${1}.tmp
samtools view -f 67 ${1}.bam | cut -f 1,3 | sort -T ${1}.tmp > ${1}.read_gene.tsv
echo "$? samtools exit status"
rm -rf ${1}.tmp
gzip -v ${1}.read_gene.tsv
echo DONE
