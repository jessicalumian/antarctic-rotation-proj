# load module
module load megahit/1.0.6-hotfix1

## link QC'ed, trimmed, and interleaved data
# isolate
ln -fs /home/jemizzi/rotation-project/quality-control/isolate/interleave-output-files-trimmed/isolate-all-reads.fastq ~/rotation-project/assembly-combined-datasets

# metagenome
ln -fs /home/jemizzi/rotation-project/raw-data/metagenomic/paired-qc-filtered-megan/10.4_ABC_4.cat.ereps.afu.fastq ~/rotation-project/assembly-combined-datasets

## combine reads with environment variables and python to feed to assembly
READS=`ls ~/rotation-project/assembly-combined-datasets/*.fastq | python -c 'import sys; print(",".join([x.strip() for x in sys.stdin.readlines()]))'`

## assembly with MEGAHIT, min contig size 1000
# note - make sure existing output directory, ie /megahit-assembly, doesn't already exist or job will fail
megahit --12 $READS --min-contig-len 1000  -o /home/jemizzi/rotation-project/assembly-combined-datasets/combined-assembly-megahit

