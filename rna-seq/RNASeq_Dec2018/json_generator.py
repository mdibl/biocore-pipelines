import json
import os

# lists all files with .json filetype in given directory
for file  in os.listdir("/Users/nmaki/Documents/GitHub/biocore-pipelines/rna-seq/RNASeq_Dec2018"):
    if file.endswith(".json"):
        print(os.path.join("/Users/nmaki/Documents/GitHub/biocore-pipelines/rna-seq/RNASeq_Dec2018", file))

