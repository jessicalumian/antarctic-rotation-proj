#!/bin/bash -l
#
#SBATCH --job-name=fastqc.sh.metagenome
#SBATCH -t 2:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/fastqc.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/fastqc.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load fastqc

fastqc /home/jemizzi/rotation-project/raw-data/metagenomic/*
