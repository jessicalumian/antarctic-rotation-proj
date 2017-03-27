#!/bin/bash -l
#
#SBATCH --job-name=bwa2-mapping-fixed-contigs-anvio-metagnome.sh.metagenome
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/bwa2-mapping-fixed-contigs-anvio-metagenome.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/bwa2-mapping-fixed-contigs-anvio-metagenome.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load bowtie2/2.2.5 samtools/1.3.1
set -e

#index reference
bwa index /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output-fixed-contigs-anvio/contigs-fixed.fa
# map raw reads to reference assembly
bwa mem /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output-fixed-contigs-anvio/contigs-fixed.fa /home/jemizzi/rotation-project/raw-data/metagenomic/paired-qc-filtered-megan/10.4_ABC_4.cat.ereps.afu.fastq > /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output-fixed-contigs-anvio/metagenome-mapped-fixed-contigs.sam

# index reference assembly with samtools
samtools faidx /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output-fixed-contigs-anvio/contigs-fixed.fa

# convert sam to bam
samtools import /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output-fixed-contigs-anvio/contigs-fixed.fa.fai /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output-fixed-contigs-anvio/metagenome-mapped-fixed-contigs.sam /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output-fixed-contigs-anvio/metagenome-mapped-fixed-contigs.bam

# sort the bam file
samtools sort /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output-fixed-contigs-anvio/metagenome-mapped-fixed-contigs.bam > /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output-fixed-contigs-anvio/metagenome-mapped-fixed-contigs.sorted.bam

# index the sorted bam file
samtools index /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output-fixed-contigs-anvio/metagenome-mapped-fixed-contigs.sorted.bam
