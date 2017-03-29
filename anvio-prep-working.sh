#!/bin/bash -l
#
#SBATCH --job-name=anvio-prep-working.sh.both
#SBATCH -t 40:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/anvio-prep-working.sh.both.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/anvio-prep-working.sh.both.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load prodigal/2.6.3 centrifuge/1.0.3-beta python3/3.6.0 bowtie2/2.2.5 samtools/1.3.1
set -e

# Assembly fasta and BAM file in anvio directory

# Concatenate metagenome and isolate contigs to contigs.fa

cat /home/jemizzi/rotation-project/assembly/metagenome/megahit-assembly/final.contigs.fa /home/jemizzi/rotation-project/assembly/isolate/megahit-assembly/final.contigs.fa > /home/jemizzi/rotation-project/visualization-anvio/combined/combined-contigs-unfixed.fa

# re-format combined input FASTA

anvi-script-reformat-fasta /home/jemizzi/rotation-project/visualization-anvio/combined/combined-contigs-unfixed.fa -o /home/jemizzi/rotation-project/visualization-anvio/combined/combined-contigs-fixed.fa --simplify-names -r /home/jemizzi/rotation-project/visualization-anvio/combined/combied.contigs.anvio.report

# generate contigs database

anvi-gen-contigs-database -f /home/jemizzi/rotation-project/visualization-anvio/combined/combined-contigs-fixed.fa -o /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.db

## Mapping: switch to bwa and samtools

# index combined contigs with fixed (simplified) assembly

bwa index /home/jemizzi/rotation-project/visualization-anvio/combined/combined-contigs-fixed.fa

# Map ISOLATE raw reads to combined fixed assembly

bwa mem /home/jemizzi/rotation-project/visualization-anvio/combined/combined-contigs-fixed.fa /home/jemizzi/rotation-project/quality-control/isolate/interleave-output-files-trimmed/isolate-all-reads.fastq > /home/jemizzi/rotation-project/visualization-anvio/combined/isolate-mapped-anvio-format.sam

# Map METAGENOME raw reads to combined fixed assembly

bwa mem /home/jemizzi/rotation-project/visualization-anvio/combined/combined-contigs-fixed.fa /home/jemizzi/rotation-project/raw-data/metagenomic/paired-qc-filtered-megan/10.4_ABC_4.cat.ereps.afu.fastq > /home/jemizzi/rotation-project/visualization-anvio/combined/metagenome-mapped-anvio-format.sam

# Index the combined fixed reference assembly with samtools

samtools faidx /home/jemizzi/rotation-project/visualization-anvio/combined/combined-contigs-fixed.fa

# Convert ISOLATE sam to bam

samtools import /home/jemizzi/rotation-project/visualization-anvio/combined/combined-contigs-fixed.fa.fai /home/jemizzi/rotation-project/visualization-anvio/combined/isolate-mapped-anvio-format.sam /home/jemizzi/rotation-project/visualization-anvio/combined/isolate_mapped_anvio_format.bam

# Convert METAGENOME sam to bam

samtools import /home/jemizzi/rotation-project/visualization-anvio/combined/combined-contigs-fixed.fa.fai /home/jemizzi/rotation-project/visualization-anvio/combined/metagenome-mapped-anvio-format.sam /home/jemizzi/rotation-project/visualization-anvio/combined/metagenome_mapped_anvio_format.bam

# Sort the ISOLATE bam file
samtools sort /home/jemizzi/rotation-project/visualization-anvio/combined/isolate_mapped_anvio_format.bam > /home/jemizzi/rotation-project/visualization-anvio/combined/isolate_mapped_anvio_format.sorted.bam

# Sort the METAGENOME bam file
samtools sort /home/jemizzi/rotation-project/visualization-anvio/combined/metagenome_mapped_anvio_format.bam > /home/jemizzi/rotation-project/visualization-anvio/combined/metagenome_mapped_anvio_format.sorted.bam

# Index the sorted ISOLATE bam file
samtools index /home/jemizzi/rotation-project/visualization-anvio/combined/isolate_mapped_anvio_format.sorted.bam

# Index the sorted METAGENOME bam file
samtools index /home/jemizzi/rotation-project/visualization-anvio/combined/metagenome_mapped_anvio_format.sorted.bam

# Back to anvio
# generate HMMS of database

anvi-run-hmms -c /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.db

# Annotate taxonomy and functions - skip for now

# create anvio profile for metagenome - note, output directory cannot already exist
# note - warning will be given that 0 genes are called. this is because no gene calling has been done yet
# inside directory with bam file (combined in this case) need .bam file and .bam.bai indexing file which has been generated in mapping step
# Fussy names - make sure to replace "-" in names with "_"
rm -fr /home/jemizzi/rotation-project/visualization-anvio/combined/meta-profile
rm -fr /home/jemizzi/rotation-project/visualization-anvio/combined/is-profile

# Create METAGENOME profile

anvi-profile -i /home/jemizzi/rotation-project/visualization-anvio/combined/metagenome_mapped_anvio_format.sorted.bam -c /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.db -o /home/jemizzi/rotation-project/visualization-anvio/combined/meta-profile -S metagenome_profile_db

# Create ISOLATE profile

anvi-profile -i /home/jemizzi/rotation-project/visualization-anvio/combined/isolate_mapped_anvio_format.sorted.bam -c /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.db -o /home/jemizzi/rotation-project/visualization-anvio/combined/is-profile -S isolate_profile_db

# move profiles to combined directory

cp /home/jemizzi/rotation-project/visualization-anvio/combined/meta-profile/PROFILE.db /home/jemizzi/rotation-project/visualization-anvio/combined/meta-PROFILE.db

cp /home/jemizzi/rotation-project/visualization-anvio/combined/is-profile/PROFILE.db /home/jemizzi/rotation-project/visualization-anvio/combined/is-PROFILE.db
