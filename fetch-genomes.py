# script from https://github.com/adina/isu-bcb-546x/blob/master/scripts/fetch-genomes.py

import urllib2
import os
import sys
import time

if len(sys.argv) != 3:
    print "USAGE: fetch-genomes.py <genome_id_list> <out_dir>"
    sys.exit(1)

url_template = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=protein&id=%s&rettype=fasta&retmode=text"

os.mkdir(sys.argv[2])

for id in open(sys.argv[1]):
    id = id.strip()
    if id == "":
        continue

    sys.stdout.write("Fetching %s..." % id)
    sys.stdout.flush()
    out_file = os.path.join(sys.argv[2], id + ".fa")
    if os.path.exists(out_file):
        print "already fetched"
        #continue

    open(out_file, "w").write(urllib2.urlopen(url_template % id).read())
    print "Done"
    time.sleep(1.0/3)
