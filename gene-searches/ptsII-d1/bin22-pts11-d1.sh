#!/bin/bash -l
#
#SBATCH --job-name=bin22-ptsII-d1.sh
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/bin22-ptsII-d1.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/bin22-ptsII-d1.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

# run these commands to download genes

# from http://blast-tutorial.readthedocs.io/en/latest/ncbi/
# download gi list from task 4

module load python/2.7.6 ncbi-blast/2.6.0+

# scrape fastas from NCBI based on GI  list downloaded from gene search (protein database, only bacteria entries in RefSeq for non-redundancy)
#python /home/jemizzi/rotation-project/scripts/fetch-genomes.py /home/jemizzi/rotation-project/gene-search-custom-db/ptsII-d1/ptsIId1-refseq-gi.gi /home/jemizzi/rotation-project/gene-search-custom-db/ptsII-d1/ptsII-d1-database-fastas

# create combined less

#cat /home/jemizzi/rotation-project/gene-search-custom-db/ptsII-d1/ptsII-d1-database-fastas/*.fa > /home/jemizzi/rotation-project/gene-search-custom-db/ptsII-d1/all-ptsII-d1.fa

# create custom protein database of ptsII-d1 genes blastdb
#makeblastdb -in /home/jemizzi/rotation-project/gene-search-custom-db/ptsII-d1/all-ptsII-d1.fa -dbtype prot -out /home/jemizzi/rotation-project/gene-search-custom-db/ptsII-d1/all-ptsII-d1.db

# query bin 22 against ptsII-d1 database
blastx -query /home/jemizzi/rotation-project/visualization-anvio/combined/SUMMARY_CONCOCT/bin_by_bin/Bin_22/Bin_22-contigs.fa -db /home/jemizzi/rotation-project/gene-search-custom-db/ptsII-d1/all-ptsII-d1.db -out /home/jemizzi/rotation-project/gene-search-custom-db/ptsII-d1/bin22-ptsII-d1-hits.out -outfmt 6
