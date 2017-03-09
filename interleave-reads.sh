#!/bin/bash -l
#
#SBATCH --job-name=interleave-reads.sh.isolate
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/interleave-reads.sh.isolate.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/interleave-reads.sh.isolate.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load python/2.7.6 khmer/2.0

for filename in /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/*_R1_*.trim.fastq
do
     # first, make the base by removing .trim.fastq
     base=$(basename $filename .trim.fastq)
     echo $base

     # now, construct the R2 filename by replacing R1 with R2
     baseR2=${base/_R1_/_R2_}
     echo $baseR2

     # construct the output filename
     output=${base/_R1_/}.fastq

     (interleave-reads.py /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/${base}.trim.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/${baseR2}.trim.fastq | \
         gzip > /home/jemizzi/rotation-project/quality-control/isolate/interleave-output-files-trimmed/$output)

done
