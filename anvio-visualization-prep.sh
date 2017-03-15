#!/bin/bash -l
#
#SBATCH --job-name=anvio-visualization-prep.sh.metagenome
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/anvio-visualization-prep.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/anvio-visualization-prep.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load bio/1.0 anvio/2.0.2 prodigal/2.6.3 centrifuge/1.0.3-beta

# Assembly fasta and BAM file in anvio directory

# Generate anvi'o contigs database
anvi-gen-contigs-database -f /home/jemizzi/rotation-project/visualization-anvio/metagenome/contigs-fixed.fa -o /home/jemizzi/rotation-project/visualization-anvio/metagenome/contigs.db

# Generate HMMS of database
anvi-run-hmms -c /home/jemizzi/rotation-project/visualization-anvio/metagenome/contigs.db

# Annotate Taxonomy
# need to have centrifuge downloaded onto peloton

# Annotate functions
# need to annotate functions first

# Profiling BAM files
# Can skip this step of bam file is indexed - included here only for reference
# anvi-init-bam SAMPLE-01-RAW.bam -o SAMPLE-01.bam

# Creating anvi-profile - incorporates stats from BAM file
#anvi-profile -i /home/jemizzi/rotation-project/visualization-anvio/metagenome/metagenome-mapped-fixed-contigs.sorted.bam -c /home/jemizzi/rotation-project/visualization-anvio/metagenome/contigs.db

# Merge anvio profiles - necessary if working with multiple samples and bam files, not this situation but kept here for reference

# Start interactive portion -- tree file is necessary, but should have been generated in an earlier step. 


