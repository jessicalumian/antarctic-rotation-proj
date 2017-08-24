# These directions run in the /Users/jessicamizzi/metagenome-rotation-proj/Humann2-analysis directory on my local computer

# 1. Download humann2 Bin_2-contigs_genefamilies_uniref50_ko.tsv from peloton

scp jemizzi@peloton.cse.ucdavis.edu:/home/jemizzi/rotation-project/annotations/humann2/Bin_2-contigs_genefamilies_cpm.tsv .

# 2. Save each page from Megan's excel sheet as tab separated (saves as .txt file, but it can be overwritten as .tsv) as KEGG-ref-<NAME>.tsv

# 3. Get rid of ^M carriage return characters, replace with line breaks
# open file in vim
# ctrl+v ctrl+M to insert correct ^M character
:%s/^M/\r/g

#4. Run 'find-comp-genes.sh' script which exports annotations for genes into new files according to gene family
bash find-comp-genes.sh

# code:
#!/bin/bash

for file in KEGG-ref*.tsv
  do
  base=$(basename $file .tsv)
  echo ${base}
  # find matching KEGG IDs in Bin_2_KEGG_humann2 and extract info line from ref sheet into new file
  grep -Fwf Bin_2_KEGG_humann2.tsv ${base}.tsv > FOUND_Bin_2-${base}.tsv
done
