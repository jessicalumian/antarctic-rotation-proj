#!/bin/bash -l
#
#SBATCH --job-name=kaiju-bin19.sh.both
#SBATCH -t 4:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-bin19.sh.both.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-bin19.sh.both.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load kaiju/1 KronaTools/2.7

kaiju -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -f /home/jemizzi/rotation-project/databases/kaiju-database/kaiju_db_nr_euk.fmi -i /home/jemizzi/rotation-project/visualization-anvio/combined/SUMMARY_CONCOCT/bin_by_bin/Bin_19/Bin_19-contigs.fa -o /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin19.out -v

# add taxonomy names
addTaxonNames -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -n /home/jemizzi/rotation-project/databases/kaiju-database/names.dmp -i /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin19.out -o /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin19.out.names

# does classification for genus leve, can change -r parameter for different levels
kaijuReport -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -n /home/jemizzi/rotation-project/databases/kaiju-database/names.dmp -i /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin19.out -r genus -o /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin19.out.summary

# make output into format for Krona html visualization software
# maybe use different input file? currently using one from first step, but maybe need more classification information
kaiju2krona -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -n /home/jemizzi/rotation-project/databases/kaiju-database/names.dmp -i /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin19.out -o /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju2krona.bin19.out

# import to Krona
ktImportText -o /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin19.out.html /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju2krona.bin19.out
