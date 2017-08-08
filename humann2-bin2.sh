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

module load python usearch samtools perlbrew bowtie2 metaphlan/2.0 bio

# set input/output and database locations

humann2 --input /home/jemizzi/rotation-project/visualization-anvio/combined/SUMMARY_CONCOCT/bin_by_bin/Bin_2/Bin_2-contigs.fa --nucleotide-database /home/jemizzi/rotation-project/databases/humann2-database/chocophlan --protein-database /home/jemizzi/rotation-project/databases/humann2-database/uniref --output /home/jemizzi/rotation-project/annotations/humann2

# download databases and utility mapping (KEGG legacy mapping)

humann2_databases --download chocophlan full /home/jemizzi/rotation-project/databases/humann2-database/chocophlan
humann2_databases --download uniref uniref50_diamond /home/jemizzi/rotation-project/databases/humann2-database/uniref
humann2_databases --download utility_mapping full /home/jemizzi/rotation-project/databases/humann2-database/utility_mapping

# convert output to CPM

humann2_renorm_table --input /home/jemizzi/rotation-project/annotations/humann2/Gene_Families/cat_gene_families --units "cpm" --output /home/jemizzi/rotation-project/annotations/humann2/Gene_Families/cat_gene_families_cpm 

# group all gene family output into one table

humann2_join_tables --input /home/jemizzi/rotation-project/annotations/humann2/Gene_Families --output /home/jemizzi/rotation-project/annotations/humann2/Gene_Families/cat_gene_families

# map gene family CPMs to pathways

humann2_regroup_table --input /home/jemizzi/rotation-project/annotations/humann2/Gene_Families/cat_gene_families_cpm --groups uniref50_ko --output /home/jemizzi/rotation-project/annotations/humann2/Gene_Families/cat_gene_families_cpm_uniref50_ko.txt 
