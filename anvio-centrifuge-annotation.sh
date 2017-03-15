#!/bin/bash -l
#
#SBATCH --job-name=anvio-centrifuge-annotation.sh.metagenome
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/anvio-centrifuge-annotation.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/anvio-centrifuge-annotation.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load bio/1.0 anvio/2.0.2 centrifuge/1.0.3-beta # insert load centrifuge when installed on cluster

## TO DO - PUT DATABASES IN $CENTRIFUGE_BASE
# export CENTRIFUGE_BASE="/path/to/a/directory"
# export PATH=$PATH:$CENTRIFUGE_BASE/centrifuge
# cd $CENTRIFUGE_BASE
# wget ftp://ftp.ccb.jhu.edu/pub/infphilo/centrifuge/data/p+h+v.tar.gz
# tar -zxvf p+h+v.tar.gz && rm -rf p+h+v.tar.gz
# to check:
# ls -lh $CENTRIFUGE_BASE/p+h+v/*cf
# should give:
# -rw-r--r--   6.5G Feb 15 13:18 $CENTRIFUGE_BASE/p+h+v/p+h+v.1.cf
# -rw-r--r--   2.3G Feb 15 13:18 $CENTRIFUGE_BASE/p+h+v/p+h+v.2.cf
# -rw-r--r--   1.4M Feb 15 13:18 $CENTRIFUGE_BASE/p+h+v/p+h+v.3.cf

# Basic Workflow
# 1. Generate contigs database
# 2. Export gene sequences
# 3. Annotate with taxonomy using Centrifuge
# 4. Import results back into contigs database
# This script does steps 2-4

# Exporting gene sequences
anvi-get-dna-sequences-for-gene-calls -c /home/jemizzi/rotation-project/visualization-anvio/metagenome/contigs.db -o /home/jemizzi/rotation-project/visualization-anvio/metagenome/gene-calls.fa

# Centrifuge to add taxonomy
# note - might need to check basenames in -x parameter
/home/jemizzi/rotation-project/software/centrifuge/centrifuge -f -x /home/jemizzi/rotation-project/software/centrifuge/p+h+v/p+h+v /home/jemizzi/rotation-project/visualization-anvio/metagenome/gene-calls.fa -S /home/jemizzi/rotation-project/visualization-anvio/metagenome/centrifuge_hits.tsv

# import results back to anvio
anvi-import-taxonomy -c /home/jemizzi/rotation-project/visualization-anvio/metagenome/contigs.db -i /home/jemizzi/rotation-project/visualization-anvio/metagenome/centrifuge_report.tsv /home/jemizzi/rotation-project/visualization-anvio/metagenome/centrifuge_hits.tsv -p /home/jemizzi/rotation-project/software/centrifuge/centrifuge
