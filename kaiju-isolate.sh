#!/bin/bash -l
#
#SBATCH --job-name=kaiju-isolate.sh.isolate
#SBATCH -t 10:00:00
#SBATCH --mem=32768
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-isolate.sh.isolate.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/kaiju-isolate.sh.isolate.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

module load kaiju/1

kaiju -t /home/jemizzi/rotation-project/databases/kaiju-database/nodes.dmp -f /home/jemizzi/rotation-project/databases/kaiju-database/kaiju_db_nr_euk.fmi -i /home/jemizzi/rotation-project/assembly/isolate/megahit-assembly/final.contigs.fa -o /home/jemizzi/rotation-project/annotations/kaiju/isolate/kaiju-output.txt
