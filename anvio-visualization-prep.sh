#!/bin/bash -l
#
#SBATCH --job-name=anvio-visualization-prep.sh.combined
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/anvio-visualization-prep.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/anvio-visualization-prep.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load bio/1.0 prodigal/2.6.3 centrifuge/1.0.3-beta python3/3.6.0

# Assembly fasta and BAM file in anvio directory

# Combine contigs from metagenome and isolate to generate combined contig database

cat /home/jemizzi/rotation-project/mapping/isolate/bwa2-samtools-output-fixed-contigs-anvio/contigs-fixed.fa /home/jemizzi/rotation-project/mapping/metagenome/bwa2-samtools-output-fixed-contigs-anvio/contigs-fixed.fa > /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.fa

# Generate anvi'o contigs database
anvi-gen-contigs-database -f /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.fa -o /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.db

# Generate HMMS of database
anvi-run-hmms -c /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.db

# Annotate Taxonomy
# punt - need to have centrifuge configured with peloton

# Annotate functions
# punt - need to annotate functions first

# Profiling BAM files
# Can skip this step of bam file is indexed (.bai file is in same dir as .bam) - included here only for reference
# anvi-init-bam SAMPLE-01-RAW.bam -o SAMPLE-01.bam

# Creating anvi-profile - incorporates stats from BAM file
anvi-profile -i /home/jemizzi/rotation-project/visualization-anvio/metagenome/metagenome-mapped-fixed-contigs.sorted.bam -c /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.db -o /home/jemizzi/rotation-project/visualization-anvio/metagenome -S metagenome-profile.db
anvi-profile -i /home/jemizzi/rotation-project/visualization-anvio/isolate/isolate-mapped-fixed-contigs.sorted.bam -c /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.db -o /home/jemizzi/rotation-project/visualization-anvio/isolate -S isolate-profile.db

# move all files to combined file - note this seems silly to do, should restructure file system
cp /home/jemizzi/rotation-project/visualization-anvio/metagenome/* /home/jemizzi/rotation-project/visualization-anvio/combined
cp /home/jemizzi/rotation-project/visualization-anvio/isolate/* /home/jemizzi/rotation-project/visualization-anvio/combined

# Merge anvio profiles for isolate and metagenome - also does binning, so just running on metagenome for now
anvi-merge /home/jemizzi/rotation-project/visualization-anvio/combined/*/PROFILE.db -o SAMPLES-MERGED -c contigs.db

# Start interactive portion -- tree file is necessary, but should have been generated in an earlier step. 


