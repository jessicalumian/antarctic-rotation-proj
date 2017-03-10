#!/bin/bash -l
#
#SBATCH --job-name=bwa2-mapping.sh.metagenome
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/bwa2-mapping.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/bwa2-mapping.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load bowtie2/2.2.5 samtools/1.3.1
set -e

#index reference
bwa index /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output/final.contigs.fa
# map raw reads to reference assembly
bwa mem /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output/final.contigs.fa /home/jemizzi/rotation-project/raw-data/metagenomic/paired-qc-filtered-megan/10.4_ABC_4.cat.ereps.afu.fastq > /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output/metagenome-mapped.sam

# index reference assembly with samtools
samtools faidx /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output/final.contigs.fa

# convert sam to bam
samtools import /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output/contigs.fa.fai /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output/metagenome-mapped.sam /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output/metagenome-mapped.bam

# sort the bam file
samtools sort /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output/metagenome-mapped.bam > /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output/metagenome-mapped.sorted.bam

# index the sorted bam file
samtools index /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output/metagenome-mapped.sorted.bam
