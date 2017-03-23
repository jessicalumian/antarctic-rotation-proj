#!/bin/bash -l
#
#SBATCH --job-name=kaiju-metagenome.sh.metagenome
#SBATCH -t 10:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-metagenome.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-metagenome.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load kaiju/1

kaiju -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -f /home/jemizzi/rotation-project/databases/kaiju-database/kaiju_db_nr_euk.fmi -i /home/jemizzi/rotation-project/assembly/metagenome/megahit-assembly/final.contigs.fa -o /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju-output-verbose.txt -v
