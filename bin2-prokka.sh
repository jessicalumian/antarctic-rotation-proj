#!/bin/bash -l
#
#SBATCH --job-name=bin2-prokka.sh
#SBATCH -t 4:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/bin2-prokka.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/bin2-prokka.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load bio

prokka --outdir /home/jemizzi/rotation-project/annotations/prokka/bin2 --prefix prokka /home/jemizzi/rotation-project/visualization-anvio/combined/SUMMARY_CONCOCT/bin_by_bin/Bin_2/Bin_2-contigs.fa
