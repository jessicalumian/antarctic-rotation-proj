#!/bin/bash -l
#
#SBATCH --job-name=bin2-sqr1-geitler-photosynth-genes-xml.sh
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/bin2-sqr1-geitler-photosynth-genes-xml.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/bin2-sqr1-geitler-photosynth-genes-xml.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

# run these commands to download genes

# from http://blast-tutorial.readthedocs.io/en/latest/ncbi/
# download gi list from task 4

module load python/2.7.6 ncbi-blast/2.6.0+

# NOT RUNNING THIS  scrape fastas from NCBI based on GI  list downloaded from gene search (protein database, only bacteria entries in RefSeq for non-redundancy)
#python /home/jemizzi/rotation-project/scripts/fetch-genomes.py /home/jemizzi/rotation-project/gene-search-custom-db/ptsII-d1/ptsIId1-refseq-gi.gi /home/jemizzi/rotation-project/gene-search-custom-db/ptsII-d1/ptsII-d1-database-fastas

# NOT RUNNING THIS  create combined less
#cat /home/jemizzi/rotation-project/gene-search-custom-db/ptsII-d1/ptsII-d1-database-fastas/*.fa > /home/jemizzi/rotation-project/gene-search-custom-db/ptsII-d1/all-ptsII-d1.fa

# create custom protein database of sqr1 genes blastdb
#makeblastdb -in /home/jemizzi/rotation-project/gene-search-custom-db/geitler-photosynth-genes-single/sqr1/sqr1-geitler-photosynth-genes-single.fa -dbtype prot -out /home/jemizzi/rotation-project/gene-search-custom-db/geitler-photosynth-genes-single/sqr1/sqr1-geitler-photosynth-genes-single.db

# query bin 2 against sqr1 database
blastx -query /home/jemizzi/rotation-project/visualization-anvio/combined/SUMMARY_CONCOCT/bin_by_bin/Bin_2/Bin_2-contigs.fa -db /home/jemizzi/rotation-project/gene-search-custom-db/geitler-photosynth-genes-single/sqr1/sqr1-geitler-photosynth-genes-single.db -out /home/jemizzi/rotation-project/gene-search-custom-db/geitler-photosynth-genes-single/sqr1/bin2-sqr1-geitler-photosynth-genes-single.xml -outfmt 5
