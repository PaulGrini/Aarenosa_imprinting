#!/bin/sh
pwd

sbatch --account=${ACCOUNT} run_read2gene.sh SxS_BR1
sbatch --account=${ACCOUNT} run_read2gene.sh SxS_BR2
sbatch --account=${ACCOUNT} run_read2gene.sh SxS_BR3
sbatch --account=${ACCOUNT} run_read2gene.sh SxS_BR4

sbatch --account=${ACCOUNT} run_read2gene.sh MxM_BR1
sbatch --account=${ACCOUNT} run_read2gene.sh MxM_BR2
sbatch --account=${ACCOUNT} run_read2gene.sh MxM_BR3
sbatch --account=${ACCOUNT} run_read2gene.sh MxM_BR4
