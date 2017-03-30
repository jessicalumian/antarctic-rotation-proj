# antarctic-rotation-proj
Workflow:

## For isolate sample:

1. Quality assessment with FastQC - [fastqc-isolate.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/isolate/fastqc-isolate.sh)
2. Quality filtering with trimmomatic [trimmomatic-no-for-loop-all-reads-isolate.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/isolate/trimmomatic-no-for-loop-all-reads-isolate.sh)
3. Interleave reads with khmer - [interleave-reads-isolate.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/isolate/interleave-reads-isolate.sh)
4. Assemble with MEGAHIT - [megahit-isolate.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/isolate/megahit-isolate.sh)
5. View assembly quality with QUAST - [quast-isolate.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/isolate/quast-isolate.sh)
6. Map reads back to assembly for coverage information using samtools - [bwa2-mapping-isolate.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/isolate/bwa2-mapping-isolate.sh)
7. Taxonomic classification, using Kaiju with Krona output - [kaiju-isolate.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/isolate/kaiju-isolate.sh)
8. Anvi'oh-no-what-am-I-doing

## For metagenome sample:

1. Quality assessment with FastQC - [fastqc-metagenome.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/metagenome/fastqc-metagenome.sh)
2. Assemble with MEGAHIT - [megahit-metagenome.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/metagenome/megahit-metagenome.sh)
5. View assembly quality with QUAST - [quast-metagenome.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/metagenome/quast-metagenome.sh)
6. Map reads back to assembly for coverage information using samtools - [bwa2-mapping-metagenome.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/metagenome/bwa2-mapping-metagenome.sh)
7. Taxonomic classification, using Kaiju with Krona output - [kaiju-metagenome.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/metagenome/kaiju-metagenome.sh)
8. Anvi'oh-no-what-am-I-doing

## Anvi'o

This is a mysterious work in progress. This script is being tweaked to generate files: [anvio-prep-working.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/anvio-prep-working.sh)
