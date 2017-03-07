#!/bin/bash -l
#
#SBATCH --job-name=quast.sh.metagenome
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/quast.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/quast.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load python/2.7.6 quast/4.3

python quast /home/jemizzi/rotation-project/assembly/metagenome/megahit-assembly/final.contigs.fa
