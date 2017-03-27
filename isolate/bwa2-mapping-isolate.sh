#!/bin/bash -l
#
#SBATCH --job-name=bwa2-mapping-isolate.sh.isolate
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/bwa2-mapping-isolate.sh.isolate.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/bwa2-mapping-isolate.sh.isolate.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load bowtie2/2.2.5 samtools/1.3.1
set -e

#index reference
bwa index /home/jemizzi/rotation-project/mapping/isolate/bwa2-samtools-output/final.contigs.fa
# map raw reads to reference assembly
bwa mem /home/jemizzi/rotation-project/mapping/isolate/bwa2-samtools-output/final.contigs.fa /home/jemizzi/rotation-project/quality-control/isolate/interleave-output-files-trimmed/isolate-all-reads.fastq > /home/jemizzi/rotation-project/mapping/isolate/bwa2-samtools-output/isolate-mapped.sam

# index reference assembly with samtools
samtools faidx /home/jemizzi/rotation-project/mapping/isolate/bwa2-samtools-output/final.contigs.fa

# convert sam to bam
samtools import /home/jemizzi/rotation-project/mapping/isolate/bwa2-samtools-output/contigs.fa.fai /home/jemizzi/rotation-project/mapping/isolate/bwa2-samtools-output/isolate-mapped.sam /home/jemizzi/rotation-project/mapping/isolate/bwa2-samtools-output/isolate-mapped.bam

# sort the bam file
samtools sort /home/jemizzi/rotation-project/mapping/isolate/bwa2-samtools-output/isolate-mapped.bam > /home/jemizzi/rotation-project/mapping/isolate/bwa2-samtools-output/isolate-mapped.sorted.bam

# index the sorted bam file
samtools index /home/jemizzi/rotation-project/mapping/isolate/bwa2-samtools-output/isolate-mapped.sorted.bam
