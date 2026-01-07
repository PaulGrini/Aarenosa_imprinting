#!/bin/sh
pwd

sbatch --account=${ACCOUNT} run_read2gene.sh SxM_BR1
sbatch --account=${ACCOUNT} run_read2gene.sh SxM_BR2
sbatch --account=${ACCOUNT} run_read2gene.sh SxM_BR3
sbatch --account=${ACCOUNT} run_read2gene.sh SxM_BR4

sbatch --account=${ACCOUNT} run_read2gene.sh MxS_BR1
sbatch --account=${ACCOUNT} run_read2gene.sh MxS_BR2
sbatch --account=${ACCOUNT} run_read2gene.sh MxS_BR3
sbatch --account=${ACCOUNT} run_read2gene.sh MxS_BR4
