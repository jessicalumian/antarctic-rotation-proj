#!/bin/bash -l
#
#SBATCH --job-name=kaiju-to-krona-metagenome.sh.metagenome
#SBATCH -t 4:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-to-krona-metagenome.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-to-krona-metagenome.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load kaiju/1 KronaTools/2.7

kaiju -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -f /home/jemizzi/rotation-project/databases/kaiju-database/kaiju_db_nr_euk.fmi -i /home/jemizzi/rotation-project/assembly/metagenome/megahit-assembly/final.contigs.fa -o /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju.metagenome.out -v

# add taxonomy names
addTaxonNames -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -n /home/jemizzi/rotation-project/databases/kaiju-database/names.dmp -i /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju.metagenome.out -o /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju.metagenome.out.names

# does classification for genus leve, can change -r parameter for different levels
kaijuReport -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -n /home/jemizzi/rotation-project/databases/kaiju-database/names.dmp -i /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju.metagenome.out -r genus -o /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju.metagenome.out.summary

# make output into format for Krona html visualization software
# maybe use different input file? currently using one from first step, but maybe need more classification information
kaiju2krona -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -n /home/jemizzi/rotation-project/databases/kaiju-database/names.dmp -i /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju.metagenome.out -o /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju2krona.metagenome.out

# import to Krona
ktImportText -o /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju.metagenome.out.html /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju2krona.metagenome.out
