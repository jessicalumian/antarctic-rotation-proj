# antarctic-rotation-proj
Workflow:

For both samples, metagenome and isolate.

1. Quality assessment with FastQC - [fastqc.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/fastqc.sh)
2. Quality filtering with trimmomatic (or comparable program)
3. Interleave reads with khmer - [interleave-reads.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/interleave-reads.sh)
4. Quality assessment again with FastQC - [fastqc.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/fastqc.sh)
5. Assemble with MEGAHIT - [megahit.sh](https://github.com/jessicamizzi/antarctic-rotation-proj/blob/master/megahit.sh)
6. For each sample, map reads back to assembly for coverage information using samtools.
7. Use anvi'o to bin samples and for visualization. Metagenome will bin into species and isolate may bin into several species.

Possible additional directions:
* look at SNPs - similar to elk workflow?
* phylogenetic classification - [Humann2](http://huttenhower.sph.harvard.edu/humann2), [Shotmap](https://github.com/sharpton/shotmap), possibly [Kaiju](http://kaiju.binf.ku.dk/)
