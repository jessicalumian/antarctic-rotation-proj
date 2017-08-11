#!/bin/bash -l
#
#SBATCH --job-name=humann2-bin2.sh
#SBATCH -t 10:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/humann2-bin2.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/humann2-bin2.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

set -e

module load python usearch samtools perlbrew bowtie2 metaphlan/2.0

# group all gene family output into one table

humann2_join_tables --input /home/jemizzi/rotation-project/annotations/humann2/Gene_Families --output /home/jemizzi/rotation-project/annotations/humann2/Gene_Families/cat_gene_families


