import json
import sys
import glob
import errno
import os

# lists all files with .json filetype in given directory
for file  in os.listdir("/Users/nmaki/Documents/GitHub/biocore-pipelines/rna-seq/RNASeq_Dec2018"):
    if file.endswith(".json"):
        print(os.path.join("/Users/nmaki/Documents/GitHub/biocore-pipelines/rna-seq/RNASeq_Dec2018", file))

path = '/Users/nmaki/Documents/GitHub/biocore-pipelines/rna-seq/RNASeq_Dec2018/*.json'
files = glob.glob(path)

# loads json files into an array and displays content
for name in files: 
    try:
        with open(name) as f:
            sys.stdout.write(f.read())
    except IOError as exc:
        if exc.errno != errno.EISDIR:
            raise

read_path = '/data/scratch/rna-seq/RNASeq_Dec2018/*.fastq'
read_files = glob.glob(read_path)

for name in read_files:
    try:
        with open(name) as rf:
            sys.stdout.write(rf.read())
    except IOError as exc:
        if exc.errno != errno.EISDIR:
            raise