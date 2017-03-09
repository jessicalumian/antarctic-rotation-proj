# antarctic-rotation-proj
Workflow:

For both samples, metagenome and isolate.

1. Quality assessment with FastQC - [fastqc.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/fastqc.sh)
2. Quality filtering with trimmomatic [trimmomatic-no-for-loop-all-reads.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/trimmomatic-no-for-loop-all-reads.sh)
3. Interleave reads with khmer - [interleave-reads.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/interleave-reads.sh)
4. Quality assessment again with FastQC - [fastqc.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/fastqc.sh)
5. Assemble with MEGAHIT - [megahit.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/megahit.sh)
6. View quality with QUAST - [quast.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/quast.sh)
7. For isolate and metagenome, map reads back to assembly for coverage information using samtools - [bwa2-mapping.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/bwa2-mapping.sh)
8. Phylogentic classification - [shotmap](https://github.com/sharpton/shotmap) or [HUMAnN](http://huttenhower.sph.harvard.edu/humann2)
9. Anvi'o to bin samples and for visualization. Metagenome will bin into species and isolate may bin into several species.

Possible additional directions:
* look at SNPs - similar to elk workflow?
* phylogenetic classification - [Humann2](http://huttenhower.sph.harvard.edu/humann2), [Shotmap](https://github.com/sharpton/shotmap), possibly [Kaiju](http://kaiju.binf.ku.dk/)
