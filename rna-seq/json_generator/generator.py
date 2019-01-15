import json
import sys
import glob
import errno
import os
import pprint

# lists all files with .fastq filetype in given directory
for file  in os.listdir('/data/scratch/rna-seq/RNASeq_Dec2018/'):
    if file.endswith(".fastq"):
        print(os.path.join("/data/scratch/rna-seq/RNASeq_Dec2018", file))

path = '/data/projects/Biocore/biocore-pipelines/rna-seq/json_generator/*.json'
files = glob.glob(path)

# loads json files into an array and displays content
for name in files: 
    try:
        with open(name) as f:
            sys.stdout.write(f.read())
    except IOError as exc:
        if exc.errno != errno.EISDIR:
            raise

template_array = []
with open('template.json') as my_file:
        for line in my_file:
                template_array.append(line)

from pprint import pprint

with open('template.json') as f:
        template = json.load(f)

pprint(template)


# read_path = '/data/scratch/rna-seq/RNASeq_Dec2018/*.fastq'
# read_files = glob.glob(read_path)

# for name in read_files: 
#     try:
#         with open(name) as f:
#             sys.stdout.write(f.read())
#     except IOError as exc:
#         if exc.errno != errno.EISDIR:
#             raise