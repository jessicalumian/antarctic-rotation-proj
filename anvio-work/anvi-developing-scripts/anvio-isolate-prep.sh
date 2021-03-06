#!/bin/bash -l
#
#SBATCH --job-name=anvio-isolate-prep.sh.isolate
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/anvio-isolate-prep.sh.isolate.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/anvio-isolate-prep.sh.isolate.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load bio/1.0 anvio/2.0.2

# Assembly fasta and BAM file in anvio directory

# re-format input FASTA

anvi-script-reformat-fasta /home/jemizzi/rotation-project/visualization-anvio/isolate/final.contigs.fa -o /home/jemizzi/rotation-project/visualization-anvio/isolate/contigs-fixed.fa -l 0 --simplify-names

# may need to redo mapping with new contigs
