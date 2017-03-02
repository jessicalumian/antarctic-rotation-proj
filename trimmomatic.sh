#!/bin/bash -l
#
#SBATCH --job-name=trimmomatic.sh.isolate
#SBATCH -t 2:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/trimmomatic.sh.isolate.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/trimmomatic.sh.isolate.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load trimmomatic

# Get Illumina Adapters
# wget link here

for filename in *_R1_*.fastq
do
     base=$(basename $filename .fastq.gz)
     echo $base
     baseR2=${base/_R1_/_R2_}
     echo $baseR2

     java -jar $TRIM/trimmomatic PE -phred33 ${base}.fastq ${baseR2}.fastq \
     intermediate/${base}.fastq intermediate/s1_se \
     intermediate/${baseR2}.fastq intermediate/s2_se \
     ILLUMINACLIP:TruSeq3-PE.fa:2:40:15 \
     LEADING:2 TRAILING:2 \
     SLIDINGWINDOW:4:2 \
     MINLEN:25

     # save the orphans
     gzip -9c intermediate/s{1,2}_se >> intermediate/orphans.fq.gz
     rm -f intermediate/s{1,2}_se

done
fastqc /home/jemizzi/rotation-project/raw-data/metagenomic/*
