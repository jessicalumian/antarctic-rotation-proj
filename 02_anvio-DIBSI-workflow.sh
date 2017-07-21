# running through DIBSI anvio workflow
# workflow: http://2017-dibsi-metagenomics.readthedocs.io/en/latest/anvio.html

# module installs
module load prodigal/2.6.3 centrifuge/1.0.3-beta python3/3.6.0 bowtie2/2.2.5 samtools/1.3.1

# link raw reads, define assembly reads for reference in script
ln -fs /home/jemizzi/rotation-project/quality-control/isolate/interleave-output-files-trimmed/isolate-all-reads.fastq ~/rotation-project/assembly-combined-datasets
ln -fs /home/jemizzi/rotation-project/raw-data/metagenomic/paired-qc-filtered-megan/10.4_ABC_4.cat.ereps.afu.fastq ~/rotation-project/assembly-combined-datasets
COASSEMBLY=`/home/jemizzi/rotation-project/assembly-combined-datasets/combined-assembly-megahit/contigs.fa`

# reformat assembly
anvi-script-reformat-fasta $COASSEMBLY -o ~/rotation-project/assembly-combined-datasets/anvio-contigs.fa --min-len 2000 --simplify-names --report ~/rotation-project/assembly-combined-datasets/name_conversions.txt

# bowtie for mapping - build index for bowtie2
bowtie2-build ~/rotation-project/assembly-combined-datasets/anvio-contigs.fa ~/rotation-project/assembly-combined-datasets/anvio-contigs

# map raw reads to assembly
for file in ~/rotation-project/assembly-combined-datasets/*.fastq
do
    bowtie2 --threads 8 -x ~/rotation-project/assembly-combined-datasets/anvio-contigs --interleaved $file -S ${file/.fastq/}.sam
    samtools view -U 4 -bS ${file/.fastq/}.sam > ${file/.fastq/}.bam
done

# convert to anvio readable format
for file in ~/rotation-project/assembly-combined-datasets/*.bam
do
    anvi-init-bam ${file} -o ${file/.bam/}.anvio.bam
done

# generate anvio contigs database
anvi-gen-contigs-database -f ~/rotation-project/assembly-combined-datasets/anvio-contigs.fa -o ~/rotation-project/assembly-combined-datasets/anvio-contigs.db

# hmm search and ID single copy genes
anvi-run-hmms -c ~/rotation-project/assembly-combined-datasets/anvio-contigs.db --num-threads 28

# layer coverage information from two samples
for file in ~/rotation-project/assembly-combined-datasets/*.anvio.bam
do
    anvi-profile -i $file -c ~/rotation-project/assembly-combined-datasets/anvio-contigs.db -T 28
done

# merge profiles and bin with CONCOCT
anvi-merge ~/rotation-project/assembly-combined-datasets/*ANVIO_PROFILE/PROFILE.db -o ~/rotation-project/assembly-combined-datasets/MERGED-SAMPLES -c ~/rotation-project/assembly-combined-datasets/anvio-contigs.db --enforce-hierarchical-clustering

# visualize data! (may need to scp and run from local comp)
anvi-interactive -p MERGED-SAMPLES/PROFILE.db -c anvio-contigs.db

