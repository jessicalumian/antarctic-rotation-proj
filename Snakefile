rule all
	input:
		'/home/jemizzi/fryxell-phormidium/input/film/nat-samp-10.4_ABC.paired.fastq'
		'/home/jemizzi/fryxell-phormidium/input/enrichment-phormidium/*.fastq'

rule fastqc_unassembled_reads
	output:
		'/home/jemizzi/fryxell-phormidium/output/fastqc/nat-samp-10.4_ABC.paired.fastq.{html,zip}'
		'/home/jemizzi/fryxell-phormidium/output/fastqc/39872_GTGAAA_L*_fastqc.{html,zip}'
# add commands here - refer to luiz example

rule trim_frxyell_enrichment
