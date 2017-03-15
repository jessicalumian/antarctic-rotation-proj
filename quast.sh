#!/bin/bash -l
#
#SBATCH --job-name=quast.sh.isolate
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/quast.sh.isolate.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/quast.sh.isolate.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load quast/4.3
# default runs on python 2.7
# create quast-output directory before running

quast.py -o /home/jemizzi/rotation-project/quality-control/isolate/quast-output /home/jemizzi/rotation-project/assembly/isolate/megahit-assembly/final.contigs.fa
