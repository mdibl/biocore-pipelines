import json
import sys
import glob
import errno
import os

# # lists all files with .json filetype in given directory
# for file  in os.listdir("/Users/nmaki/Documents/GitHub/biocore-pipelines/rna-seq/RNASeq_Dec2018"):
#     if file.endswith(".json"):
#         print(os.path.join("/Users/nmaki/Documents/GitHub/biocore-pipelines/rna-seq/RNASeq_Dec2018", file))

path = '/Users/nmaki/Documents/GitHub/biocore-pipelines/rna-seq/RNASeq_Dec2018/*.json'
files = glob.glob(path)

for name in files: 
    try:
        with open(name) as f:
            sys.stdout.write(f.read())
    except IOError as exc:
        if exc.errno != errno.EISDIR:
            raise