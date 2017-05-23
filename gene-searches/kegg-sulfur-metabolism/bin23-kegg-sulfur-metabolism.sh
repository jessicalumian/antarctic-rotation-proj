#!/bin/bash -l
#
#SBATCH --job-name=bin23-kegg-sulfur-metabolism.sh
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/bin23-kegg-sulfur-metabolism.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/bin23-kegg-sulfur-metabolism.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

# run these commands to download genes

# from http://blast-tutorial.readthedocs.io/en/latest/ncbi/
# download gi list from task 4

module load python/2.7.6 ncbi-blast/2.6.0+

# scrape fastas from NCBI based on GI  list downloaded from gene search (protein database, only bacteria entries in RefSeq for non-redundancy)
#python /home/jemizzi/rotation-project/scripts/fetch-genomes.py /home/jemizzi/rotation-project/gene-search-custom-db/kegg-sulfur-metabolism/sulfur-metabolism-list.gi /home/jemizzi/rotation-project/gene-search-custom-db/kegg-sulfur-metabolism/kegg-sulfur-metabolism-database-fastas

# create combined less

#cat /home/jemizzi/rotation-project/gene-search-custom-db/kegg-sulfur-metabolism/kegg-sulfur-metabolism-database-fastas/*.fa > /home/jemizzi/rotation-project/gene-search-custom-db/kegg-sulfur-metabolism/all-kegg-sulfur-metabolism.fa

# create custom protein database of sqr genes blastdb
#makeblastdb -in /home/jemizzi/rotation-project/gene-search-custom-db/kegg-sulfur-metabolism/all-kegg-sulfur-metabolism.fa -dbtype prot -out /home/jemizzi/rotation-project/gene-search-custom-db/kegg-sulfur-metabolism/all-kegg-sulfur-metabolism.db

# query bin 23 against sqr database
blastx -query /home/jemizzi/rotation-project/visualization-anvio/combined/SUMMARY_CONCOCT/bin_by_bin/Bin_23/Bin_23-contigs.fa -db /home/jemizzi/rotation-project/gene-search-custom-db/kegg-sulfur-metabolism/all-kegg-sulfur-metabolism.db -out /home/jemizzi/rotation-project/gene-search-custom-db/kegg-sulfur-metabolism/bin23-kegg-sulfur-metabolism-hits.out -outfmt 6
