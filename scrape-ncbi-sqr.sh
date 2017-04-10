#!/bin/bash -l
#
#SBATCH --job-name=scrape-ncbi-sqr.sh
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/scrape-ncbi-sqr.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/scrape-ncbi-sqr.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

# run these commands to download genes

# from http://blast-tutorial.readthedocs.io/en/latest/ncbi/
# download gi list from task 4

module load python/2.7.6

python /home/jemizzi/rotation-project/scripts/fetch-genomes.py /home/jemizzi/rotation-project/sqr-custom-metagenome/sqr-sequence.gi /home/jemizzi/rotation-project/sqr-custom-metagenome/sqr-database-fastas
