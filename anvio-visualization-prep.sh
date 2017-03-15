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
anvi-gen-contigs-database -f /home/jemizzi/rotation-project/visualization-anvio/metagenome/contigs-fixed.fa -o /home/jemizzi/rotation-project/visualization-anvio/metagenome/contigs-meta.db
# anvi-gen-contigs-database -f /home/jemizzi/rotation-project/visualization-anvio/isolate/contigs-fixed.fa -o /home/jemizzi/rotation-project/visualization-anvio/isolate/contigs-is.db

# Generate HMMS of database
anvi-run-hmms -c /home/jemizzi/rotation-project/visualization-anvio/metagenome/contigs-meta.db
# anvi-run-hmms -c /home/jemizzi/rotation-project/visualization-anvio/isolate/contigs-is.db

# Annotate Taxonomy
# punt - need to have centrifuge configured with peloton

# Annotate functions
# punt - need to annotate functions first

# Profiling BAM files
# Can skip this step of bam file is indexed (.bai file is in same dir as .bam( - included here only for reference
# anvi-init-bam SAMPLE-01-RAW.bam -o SAMPLE-01.bam

# Creating anvi-profile - incorporates stats from BAM file
anvi-profile -i /home/jemizzi/rotation-project/visualization-anvio/metagenome/metagenome-mapped-fixed-contigs.sorted.bam -c /home/jemizzi/rotation-project/visualization-anvio/metagenome/contigs-meta.db
#anvi-profile -i /home/jemizzi/rotation-project/visualization-anvio/isolate/isolate-mapped-fixed-contigs.sorted.bam -c /home/jemizzi/rotation-project/visualization-anvio/isolate/contigs-is.db

# move all files to combined file - note this seems silly to do, should restructure file system
cp /home/jemizzi/rotation-project/visualization-anvio/metagenome/* /home/jemizzi/rotation-project/visualization-anvio/combined-final-for-merging
#cp /home/jemizzi/rotation-project/visualization-anvio/isolate/* /home/jemizzi/rotation-project/visualization-anvio/combined-final-for-merging

# Merge anvio profiles for isolate and metagenome - also does binning, so just running on metagenome for now
anvi-merge /home/jemizzi/rotation-project/visualization-anvio/combined-final-for-merging/*/PROFILE.db -o SAMPLES-MERGED -c contigs-meta.db

# Start interactive portion -- tree file is necessary, but should have been generated in an earlier step. 


