#!/bin/bash -l
#
#SBATCH --job-name=fastqc-isolate.sh.isolate
#SBATCH -t 2:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/fastqc-isolate.sh.isolate.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/fastqc-isolate.sh.isolate.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load fastqc/0.11.5

fastqc /home/jemizzi/rotation-project/raw-data/isolate/*
