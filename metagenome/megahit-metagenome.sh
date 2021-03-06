#!/bin/bash -l
#
#SBATCH --job-name=megahit-metagenome.sh.metagenome
#SBATCH -t 4:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/megahit-metagenome.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/megahit-metagenome.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load megahit/1.0.6-hotfix1

# note - make sure existing output directory, ie /megahit-assembly, doesn't already exist or job will fail
megahit --12 /home/jemizzi/rotation-project/raw-data/metagenomic/paired-qc-filtered-megan/10.4_ABC_4.cat.ereps.afu.fastq -o /home/jemizzi/rotation-project/assembly/metagenome/megahit-assembly
