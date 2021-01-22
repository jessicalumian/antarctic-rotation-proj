#!/bin/bash -l
#
#SBATCH --job-name=humann2-bin2-3-cpm.sh
#SBATCH -t 10:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/humann2-bin2-3-cpm.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/humann2-bin2-3-cpm.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

set -e

module load bio

# convert output to CPM

humann2_renorm_table --input /home/jemizzi/rotation-project/annotations/humann2/Bin_2-contigs_genefamilies.tsv --units "cpm" --output /home/jemizzi/rotation-project/annotations/humann2/Bin_2-contigs_genefamilies_cpm.tsv
