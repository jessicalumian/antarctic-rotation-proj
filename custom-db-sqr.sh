#!/bin/bash -l
#
#SBATCH --job-name=custom-db-sqr.sh
#SBATCH -t 40:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/custom-db-sqr.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/custom-db-sqr.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load ncbi-blast/2.6.0+

# cat all scripts from ncbi scrape
# cat /home/jemizzi/rotation-project/sqr-custom-metagenome/sqr-database-fastas/* >> /home/jemizzi/rotation-project/sqr-custom-metagenome/all-sqr-fastas

# create blast formatted database
makeblastdb -in /home/jemizzi/rotation-project/sqr-custom-metagenome/all-sqr.fa -dbtype nucl -out /home/jemizzi/rotation-project/sqr-custom-metagenome/all-sqr.db 

# query

blastn -query /home/jemizzi/rotation-project/assembly/metagenome/megahit-assembly/final.contigs.fa -db /home/jemizzi/rotation-project/sqr-custom-metagenome/all-sqr.db -out /home/jemizzi/rotation-project/sqr-custom-metagenome/sqr-metagenome-hits.out -outfmt 6
