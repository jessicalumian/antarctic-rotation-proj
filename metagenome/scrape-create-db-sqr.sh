#!/bin/bash -l
#
#SBATCH --job-name=scrape-create-db-sqr.sh
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/scrape-create-db-sqr.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/scrape-create-db-sqr.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

# run these commands to download genes

# from http://blast-tutorial.readthedocs.io/en/latest/ncbi/
# download gi list from task 4

module load python/2.7.6

# scrape fastas from NCBI based on GI  list downloaded from gene search (protein database, only bacteria entries in RefSeq for non-redundancy)
python /home/jemizzi/rotation-project/scripts/fetch-genomes.py /home/jemizzi/rotation-project/gene-search-custom-db/sqr/sqr-refseq-ids.seq /home/jemizzi/rotation-project/gene-search-custom-db/sqr/sqr-database-fastas

# combine all fastas to one file to create database
cat /home/jemizzi/rotation-project/gene-search-custom-db/sqr/sqr-database-fastas >> /home/jemizzi/rotation-project/gene-search-custom-db/sqr/all-sqr.fa

# create custom protein database of sqr genes blastdb
makeblastdb -in /home/jemizzi/rotation-project/gene-search-custom-db/sqr/all-sqr.fa -dbtype prot -out /home/jemizzi/rotation-project/gene-search-custom-db/sqr/all-sqr.db

# query metagenomic assembly against sqr database
blastx -query /home/jemizzi/rotation-project/assembly/metagenome/megahit-assembly/final.contigs.fa -db /home/jemizzi/rotation-project/gene-search-custom-db/sqr/all-sqr.db -out /home/jemizzi/rotation-project/gene-search-custom-db/sqr/sqr-metagenome-hits.out -outfmt 6
