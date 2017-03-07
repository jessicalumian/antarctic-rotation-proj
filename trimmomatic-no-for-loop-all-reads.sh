#!/bin/bash -l
#
#SBATCH --job-name=trimmomatic.sh.isolate
#SBATCH -t 2:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/trimmomatic-no-for-loop-all-reads.sh.isolate.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/trimmomatic-no-for-loop-all-reads.sh.isolate.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load trimmomatic/0.33

# Get Illumina Adapters
wget https://anonscm.debian.org/cgit/debian-med/trimmomatic.git/plain/adapters/TruSeq3-PE-2.fa

java -jar /share/apps/Trimmomatic-0.33/trimmomatic-0.33.jar PE -phred33 /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/39872_GTGAAA_L002_R1_001.fastq /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/39872_GTGAAA_L002_R2_001.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/39872_GTGAAA_L002_R1_001.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s1_se /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/39872_GTGAAA_L002_R2_001.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s2_se ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:25

java -jar /share/apps/Trimmomatic-0.33/trimmomatic-0.33.jar PE -phred33 /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/39872_GTGAAA_L002_R1_002.fastq /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/39872_GTGAAA_L002_R2_002.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/39872_GTGAAA_L002_R1_002.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s1_se /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/39872_GTGAAA_L002_R2_002.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s2_se ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:25

java -jar /share/apps/Trimmomatic-0.33/trimmomatic-0.33.jar PE -phred33 /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/39872_GTGAAA_L002_R1_003.fastq /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/39872_GTGAAA_L002_R2_003.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/39872_GTGAAA_L002_R1_003.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s1_se /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/39872_GTGAAA_L002_R2_003.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s2_se ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:25

java -jar /share/apps/Trimmomatic-0.33/trimmomatic-0.33.jar PE -phred33 /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/39872_GTGAAA_L002_R1_004.fastq /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/39872_GTGAAA_L002_R2_004.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/39872_GTGAAA_L002_R1_004.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s1_se /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/39872_GTGAAA_L002_R2_004.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s2_se ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:25

java -jar /share/apps/Trimmomatic-0.33/trimmomatic-0.33.jar PE -phred33 /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/39872_GTGAAA_L002_R1_005.fastq /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/39872_GTGAAA_L002_R2_005.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/39872_GTGAAA_L002_R1_005.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s1_se /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/39872_GTGAAA_L002_R2_005.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s2_se ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:25

java -jar /share/apps/Trimmomatic-0.33/trimmomatic-0.33.jar PE -phred33 /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/39872_GTGAAA_L002_R1_006.fastq /home/jemizzi/rotation-project/raw-data/isolate/unpaired-qc-raw/39872_GTGAAA_L002_R2_006.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/39872_GTGAAA_L002_R1_006.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s1_se /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/39872_GTGAAA_L002_R2_006.fastq /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s2_se ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:25

# save the orphans
gzip -9c /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s{1,2}_se >> /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/orphans.fq.gz
rm -f /home/jemizzi/rotation-project/quality-control/isolate/trimmomatic-output/s{1,2}_se
rm TruSeq3-PE-2.fa
