#!/bin/bash -l
#
#SBATCH --job-name=trimmomatic.sh.isolate
#SBATCH -t 2:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/trimmomatic.sh.isolate.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/trimmomatic.sh.isolate.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load trimmomatic/0.33

# Get Illumina Adapters
wget https://anonscm.debian.org/cgit/debian-med/trimmomatic.git/plain/adapters/TruSeq3-PE-2.fa

for filename in /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/*_R1_*.fastq
do
     base=$(basename $filename .fastq)
     echo $base
     baseR2=${base/_R1_/_R2_}
     echo $baseR2

     java -jar /share/apps/Trimmomatic-0.33/trimmomatic-0.33.jar PE -phred33 \
     # input
     /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/${base}.fastq \
     /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/${baseR2}.fastq \
     # output
     /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/${base}.trim.fastq \
     /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s1_se \
     /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/${baseR2}.trim.fastq \
     /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s2_se \
     # parameters - based on suggestions from user manual
     ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 \
     LEADING:3 TRAILING:3 \
     SLIDINGWINDOW:4:15 \
     MINLEN:25

     # save the orphans
     gzip -9c /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s{1,2}_se >> /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/orphans.fq.gz
     rm -f /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s{1,2}_se

done

rm TruSeq3-PE-2.fa
