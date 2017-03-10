#!/bin/bash -l
#
#SBATCH --job-name=quast.sh.metagenome
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/quast.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/quast.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load quast/4.3
# default runs on pythong 2.7

quast.py -o /home/jemizzi/rotation-project/quality-control/metagenome/quast-output /home/jemizzi/rotation-project/assembly/metagenome/megahit-assembly/final.contigs.fa
