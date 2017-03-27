#!/bin/bash -l
#
#SBATCH --job-name=megahit-isolate.sh.isolate
#SBATCH -t 4:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/megahit.sh.isolate.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/megahit.sh.isolate.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load megahit/1.0.6-hotfix1

# note - make sure existing output directory, ie /megahit-assembly, doesn't already exist or job will fail
megahit --12 /home/jemizzi/rotation-project/quality-control/isolate/interleave-output-files-trimmed/isolate-all-reads.fastq -o /home/jemizzi/rotation-project/assembly/isolate/megahit-assembly
