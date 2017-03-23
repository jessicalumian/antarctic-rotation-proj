#!/bin/bash -l
#
#SBATCH --job-name=krona-formatting.sh.metagenome
#SBATCH -t 2:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-to-krona.sh.metagenome.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-to-krona.sh.metagenome.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load kaiju/1 KronaTools/2.7

ktImportText -o /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju.metagenome.out.html /home/jemizzi/rotation-project/annotations/kaiju/metagenome/kaiju2krona.metagenome.out
