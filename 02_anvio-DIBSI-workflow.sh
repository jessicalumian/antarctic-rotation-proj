# running through DIBSI anvio workflow
# workflow: http://2017-dibsi-metagenomics.readthedocs.io/en/latest/anvio.html

# module installs
module load prodigal/2.6.3 centrifuge/1.0.3-beta python3/3.6.0 bowtie2/2.2.5 samtools/1.3.1

# link raw reads, define assembly reads for reference in script
ln -fs /home/jemizzi/rotation-project/quality-control/isolate/interleave-output-files-trimmed/isolate-all-reads.fastq ~/rotation-project/anvio-DIBSI
ln -fs /home/jemizzi/rotation-project/raw-data/metagenomic/paired-qc-filtered-megan/10.4_ABC_4.cat.ereps.afu.fastq ~/rotation-project/anvio-DIBSI
ln -fs /home/jemizzi/rotation-project/assembly-combined-datasets/combined-assembly-megahit/final.contigs.fa ~/rotation-project/anvio-DIBSI

# reformat assembly
anvi-script-reformat-fasta /home/jemizzi/rotation-project/assembly-combined-datasets/combined-assembly-megahit/final.contigs.fa -o ~/rotation-project/anvio-DIBSI/anvio-contigs.fa --min-len 2000 --simplify-names --report ~/rotation-project/anvio-DIBSI/name_conversions.txt

# bowtie for mapping - build index for bowtie2
bowtie2-build ~/rotation-project/anvio-DIBSI/anvio-contigs.fa ~/rotation-project/anvio-DIBSI/anvio-contigs

# de interleave reads for bowtie
module unload python3
module load python/2.7.6 khmer/2.0
for filename in /home/jemizzi/rotation-project/anvio-DIBSI/*.fastq
do
     # first, make the base by removing .fastq
     base=$(basename $filename .fastq)
     echo $base
     (split-paired-reads.py /home/jemizzi/rotation-project/anvio-DIBSI/${base}.fastq -1 /home/jemizzi/rotation-project/anvio-DIBSI/${base}_R1_.fastq -2 /home/jemizzi/rotation-project/anvio-DIBSI/${base}_R2_.fastq )
done

# map raw reads to assembly
for file in ~/rotation-project/anvio-DIBSI/*.fastq
do
    base1=$(basename $file .fastq)
    base2=${base/_R1_/_R2_}
    trunk=$(basename $file _?_.fastq)
    bowtie2 --threads 8 -x ~/rotation-project/anvio-DIBSI/anvio-contigs -1 $base1 -2 $base2 -S ${trunk/.fastq/}.sam
    samtools view -U 4 -bS ${trunk/.fastq/}.sam > ${trunk/.fastq/}.bam
done

# convert to anvio readable format
for file in ~/rotation-project/anvio-DIBSI/*.bam
do
    anvi-init-bam ${file} -o ${file/.bam/}.anvio.bam
done

# generate anvio contigs database
anvi-gen-contigs-database -f ~/rotation-project/anvio-DIBSI/anvio-contigs.fa -o ~/rotation-project/anvio-DIBSI/anvio-contigs.db

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

