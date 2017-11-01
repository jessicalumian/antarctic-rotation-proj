#!/bin/bash -l
#
#SBATCH --job-name=humann2-bin2-4-map-genes.sh
#SBATCH -t 10:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/humann2-bin2-4-map-genes.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/humann2-bin2-4-map-genes.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

set -e

module load bio

# map gene family CPMs to pathways

humann2_regroup_table --input /home/jemizzi/rotation-project/annotations/humann2/Bin_2-contigs_genefamilies.tsv --groups uniref50_ko --output /home/jemizzi/rotation-project/annotations/humann2/Bin_2-contigs_genefamilies_uniref50_ko.tsv
