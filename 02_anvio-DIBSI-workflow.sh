# running through DIBSI anvio workflow
# workflow: http://2017-dibsi-metagenomics.readthedocs.io/en/latest/anvio.html

# module installs - module load bio includes bowtie v2.3.2
module load bio prodigal/2.6.3 centrifuge/1.0.3-beta python3/3.6.0 samtools/1.3.1

# link raw reads, define assembly reads for reference in script
ln -fs /home/jemizzi/rotation-project/quality-control/isolate/interleave-output-files-trimmed/isolate-all-reads.fastq ~/rotation-project/anvio-DIBSI
ln -fs /home/jemizzi/rotation-project/raw-data/metagenomic/paired-qc-filtered-megan/10.4_ABC_4.cat.ereps.afu.fastq ~/rotation-project/anvio-DIBSI
ln -fs /home/jemizzi/rotation-project/assembly-combined-datasets/combined-assembly-megahit/final.contigs.fa ~/rotation-project/anvio-DIBSI

# reformat assembly
anvi-script-reformat-fasta /home/jemizzi/rotation-project/assembly-combined-datasets/combined-assembly-megahit/final.contigs.fa -o ~/rotation-project/anvio-DIBSI/anvio-contigs.fa --min-len 2000 --simplify-names --report ~/rotation-project/anvio-DIBSI/name_conversions.txt

# bowtie for mapping - build index for bowtie2
module unload python3/3.6.0
module load python/2.7.6
bowtie2-build ~/rotation-project/anvio-DIBSI/anvio-contigs.fa ~/rotation-project/anvio-DIBSI/anvio-contigs

# map raw reads to assembly
for file in *.fastq
do
    bowtie2 --threads 8 -x anvio-contigs --interleaved $file -S ${file/.fastq/}.sam
    samtools view -U 4 -bS ${file/.fastq/}.sam > ${file/.fastq/}.bam
done

# convert to anvio readable format
module unload python/2.7.6
module load python3/3.6.0

for file in ~/rotation-project/anvio-DIBSI/*.bam
do
    anvi-init-bam ${file} -o ${file/.bam/}.anvio.bam
done

# generate anvio contigs database
anvi-gen-contigs-database -f ~/rotation-project/anvio-DIBSI/anvio-contigs.fa -o ~/rotation-project/anvio-DIBSI/anvio-contigs.db

# hmm search and ID single copy genes
anvi-run-hmms -c ~/rotation-project/anvio-DIBSI/anvio-contigs.db --num-threads 28

# layer coverage information from two samples
for file in ~/rotation-project/anvio-DIBSI/*.anvio.bam
do
    anvi-profile -i $file -c ~/rotation-project/anvio-DIBSI/anvio-contigs.db -T 28
done

# merge profiles and bin with CONCOCT
anvi-merge ~/rotation-project/anvio-DIBSI/*ANVIO_PROFILE/PROFILE.db -o ~/rotation-project/anvio-DIBSI/MERGED-SAMPLES -c ~/rotation-project/anvio-DIBSI/anvio-contigs.db --enforce-hierarchical-clustering

# visualize data! (may need to scp and run from local comp)
anvi-interactive -p MERGED-SAMPLES/PROFILE.db -c anvio-contigs.db

# bin data with CONCOCT
anvi-summarize -p MERGED-SAMPLES/PROFILE.db -c anvio-contigs.db -o SAMPLES-SUMMARY -C CONCOCT

