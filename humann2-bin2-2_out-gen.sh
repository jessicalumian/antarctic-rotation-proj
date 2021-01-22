#!/bin/bash -l
#
#SBATCH --job-name=humann2-bin2-2_out-gen.sh
#SBATCH -t 10:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/humann2-bin2-2_out-gen.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/humann2-bin2-2_out-gen.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

set -e

module load python usearch samtools perlbrew bowtie2 metaphlan/2.0

humann2 --input /home/jemizzi/rotation-project/visualization-anvio/combined/SUMMARY_CONCOCT/bin_by_bin/Bin_2/Bin_2-contigs.fa --nucleotide-database /home/jemizzi/rotation-project/databases/humann2-database/chocophlan --protein-database /home/jemizzi/rotation-project/databases/humann2-database/uniref --output /home/jemizzi/rotation-project/annotations/humann2
