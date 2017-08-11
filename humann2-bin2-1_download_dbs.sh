#!/bin/bash -l
#
#SBATCH --job-name=humann2-bin2.sh
#SBATCH -t 10:00:00
#SBATCH --mem=57344
#SBATCH -o /home/jemizzi/rotation-project/scripts/error-output-reports/humann2-bin2.sh.out
#SBATCH -e /home/jemizzi/rotation-project/scripts/error-output-reports/humann2-bin2.sh.err
#SBATCH --mail-user=jemizzi@ucdavis.edu
#SBATCH --mail-type=ALL

set -e

module load bio

# download databases and utility mapping (KEGG legacy mapping)

humann2_databases --download chocophlan full /home/jemizzi/rotation-project/databases/humann2-database/
humann2_databases --download uniref uniref50_diamond /home/jemizzi/rotation-project/databases/humann2-database/
humann2_databases --download utility_mapping full /home/jemizzi/rotation-project/databases/humann2-database/
