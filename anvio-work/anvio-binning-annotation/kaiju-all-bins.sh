#!/bin/bash -l
#
#SBATCH --job-name=kaiju-bin17.sh.both
#SBATCH -t 4:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-bin17.sh.both.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-bin17.sh.both.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load kaiju/1 KronaTools/2.7

for bincontigs in /home/jemizzi/rotation-project/visualization-anvio/combined/SUMMARY_CONCOCT/bin_by_bin/Bin_*/Bin_*-contigs.fa

do

  print ${bincontigs}

  kaiju -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -f /home/jemizzi/rotation-project/databases/kaiju-database/kaiju_db_nr_euk.fmi -i /home/jemizzi/rotation-project/visualization-anvio/combined/SUMMARY_CONCOCT/bin_by_bin/${bincontigs} -o /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin17.out -v

# add taxonomy names
addTaxonNames -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -n /home/jemizzi/rotation-project/databases/kaiju-database/names.dmp -i /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin17.out -o /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin17.out.names

# does classification for genus leve, can change -r parameter for different levels
kaijuReport -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -n /home/jemizzi/rotation-project/databases/kaiju-database/names.dmp -i /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin17.out -r genus -o /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin17.out.summary

# make output into format for Krona html visualization software
# maybe use different input file? currently using one from first step, but maybe need more classification information
kaiju2krona -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -n /home/jemizzi/rotation-project/databases/kaiju-database/names.dmp -i /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin17.out -o /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju2krona.bin17.out

# import to Krona
ktImportText -o /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju.bin17.out.html /home/jemizzi/rotation-project/annotations/kaiju/anvio-bins/kaiju2krona.bin17.out
