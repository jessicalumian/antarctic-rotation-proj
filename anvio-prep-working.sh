#!/bin/bash -l
#
#SBATCH --job-name=anvio-prep-working.sh.metagenome
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/anvio-prep-working.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/anvio-prep-working.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load prodigal/2.6.3 centrifuge/1.0.3-beta python3/3.6.0

# Assembly fasta and BAM file in anvio directory

# re-format metagenome input FASTA

#anvi-script-reformat-fasta /home/jemizzi/rotation-project/visualization-anvio/metagenome/final.contigs.fa -o /home/jemizzi/rotation-project/visualization-anvio/combined/metagenome-contigs-fixed.fa --simplify-names -r /home/jemizzi/rotation-project/visualization-anvio/combined/metagenome.anvio.report

# re-format isolate input FASTA

#anvi-script-reformat-fasta /home/jemizzi/rotation-project/visualization-anvio/isolate/final.contigs.fa -o /home/jemizzi/rotation-project/visualization-anvio/combined/isolate-contigs-fixed.fa --simplify-names -r /home/jemizzi/rotation-project/visualization-anvio/combined/isolate.anvio.report

# Concatenate metagenome and isolate contigs to contigs.fa

#cat /home/jemizzi/rotation-project/visualization-anvio/combined/metagenome-contigs-fixed.fa /home/jemizzi/rotation-project/visualization-anvio/combined/isolate-contigs-fixed.fa > /home/jemizzi/rotation-project/visualization-anvio/combined/combined-contigs.fa

# generate contigs database

#anvi-gen-contigs-database -f /home/jemizzi/rotation-project/visualization-anvio/combined/combined-contigs.fa -o /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.db

# generate HMMS of database

#anvi-run-hmms -c /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.db

# Annotate taxonomy and functions - skip for now

# create anvio profile for metagenome - note, output directory cannot already exist
# note - warning will be given that 0 genes are called. this is because no gene calling has been done yet
# inside directory with bam file (combined in this case) need .bam file and .bam.bai indexing file which has been generated in mapping step
# Fussy names - make sure to replace "-" in names with "_"
rm -fr /home/jemizzi/rotation-project/visualization-anvio/metagenome/profile

anvi-profile -i /home/jemizzi/rotation-project/visualization-anvio/combined/metagenome_mapped_fixed_contigs.sorted.bam -c /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.db -o /home/jemizzi/rotation-project/visualization-anvio/combined/meta-profile -S metagenome_profile_db

anvi-profile -i /home/jemizzi/rotation-project/visualization-anvio/combined/isolate_mapped_fixed_contigs.sorted.bam -c /home/jemizzi/rotation-project/visualization-anvio/combined/contigs.db -o /home/jemizzi/rotation-project/visualization-anvio/combined/is-profile -S isolate_profile_db

# move profiles to combined directory

cp /home/jemizzi/rotation-project/visualization-anvio/combined/meta-profile/PROFILE.db /home/jemizzi/rotation-project/visualization-anvio/combined/meta-PROFILE.db

cp /home/jemizzi/rotation-project/visualization-anvio/combined/is-profile/PROFILE.db /home/jemizzi/rotation-project/visualization-anvio/combined/is-PROFILE.db
