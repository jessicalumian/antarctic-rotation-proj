#!/bin/bash -l
#
#SBATCH --job-name=metagenome-geitler-photosynth-genes-prefasta.sh
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/metagenome-geitler-photosynth-genes-prefasta.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/metagenome-geitler-photosynth-genes-prefasta.sh.err
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

# create custom protein database of geitler-photosynth-genes genes blastdb
# not running because db has been made
#makeblastdb -in /home/jemizzi/rotation-project/gene-search-custom-db/geitler-photosynth-genes/geitler-photosynth-genes.fa -dbtype prot -out /home/jemizzi/rotation-project/gene-search-custom-db/geitler-photosynth-genes/geitler-photosynth-genes.db

# query bin 2 against geitler-photosynth-genes database
blastx -query /home/jemizzi/rotation-project/assembly/metagenome/megahit-assembly/final.contigs.fa -db /home/jemizzi/rotation-project/gene-search-custom-db/geitler-photosynth-genes/geitler-photosynth-genes.db -out /home/jemizzi/rotation-project/gene-search-custom-db/geitler-photosynth-genes/metagenome-geitler-photosynth-genes-prefasta.out -outfmt "6 qseqid  qseq" -max_target_seqs 1 -evalue 1e-6
