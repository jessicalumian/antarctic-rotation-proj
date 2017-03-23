#!/bin/bash -l
#
#SBATCH --job-name=kaiju-to-krona.sh.metagenome
#SBATCH -t 2:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-to-krona.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-to-krona.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load kaiju/1

kaiju2krona -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -n /home/jemizzi/rotation-project/databases/kaiju-database/names.dmp -i /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju-output-short.txt -o /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju2krona.metagenome.out
