#!/bin/bash -l
#
#SBATCH --job-name=megahit.sh.metagenome
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/megahit.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/megahit.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load megahit/1.0.6-hotfix1

megahit --12 /home/jemizzi/rotation-project/raw-data/metagenomic/paired-qc-filtered-megan/10.4_ABC_4.cat.ereps.afu.fastq -o /home/jemizzi/rotation-project/assembly/metagenome/megahit-assembly
