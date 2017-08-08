#!/bin/bash -l
#
#SBATCH --job-name=bin2-D1-jungblut.sh
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/bin2-D1-jungblut.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/bin2-D1-jungblut.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

# run these commands to download genes

# from http://blast-tutorial.readthedocs.io/en/latest/ncbi/
# download gi list from task 4

module load python/2.7.6 ncbi-blast/2.6.0+

# create custom protein database blastdb
makeblastdb -in /home/jemizzi/rotation-project/gene-search-custom-db/D1-jungblut/D1-jungblut.fa -dbtype prot -out /home/jemizzi/rotation-project/gene-search-custom-db/D1-jungblut/D1-jungblut.db 

# query bin 2 against custom database
blastx -query /home/jemizzi/rotation-project/visualization-anvio/combined/SUMMARY_CONCOCT/bin_by_bin/Bin_2/Bin_2-contigs.fa -db /home/jemizzi/rotation-project/gene-search-custom-db/D1-jungblut/D1-jungblut.db -out /home/jemizzi/rotation-project/gene-search-custom-db/D1-jungblut/bin2-D1-jungblut-fmt6.out -outfmt 6
