#!/bin/bash -l
#
#SBATCH --job-name=kaiju-names-gen-report.sh.metagenome
#SBATCH -t 4:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-names-gen-report.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-names-gen-report.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load kaiju/1

addTaxonNames -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -n /home/jemizzi/rotation-project/databases/kaiju-database/names.dmp -i /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju-output-short.txt -o /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju-output-short.names

kaijuReport -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -n /home/jemizzi/rotation-project/databases/kaiju-database/names.dmp -i /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju-output-short.txt -r genus -o /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju.out.metagenome.summary
