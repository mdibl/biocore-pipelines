import json
import sys
import glob
import errno
import os
import pprint

# lists all files with .fastq filetype in given directory
for file  in os.listdir('/data/scratch/rna-seq/JimCoffman/RNASeq_Dec2018/'):
    if file.endswith(".fastq"):
        print(os.path.join("/data/scratch/rna-seq/JimCoffman/RNASeq_Dec2018", file))

path = '/data/projects/Biocore/biocore-pipelines/rna-seq/json_generator/*.json'
files = glob.glob(path)


for name in files: 
    try:
        with open(name) as f:
            sys.stdout.write(f.read())
    except IOError as exc:
        if exc.errno != errno.EISDIR:
            raise

# open design file and displays contents

design_file = open('Sample_DF_JR08-18.txt','r')

contents = design_file.read()

print (contents)

design_file.close()


# loads json files into an array and displays content
template_array = []
with open('template.json') as my_file:
        for line in my_file:
                template_array.append(line)

from pprint import pprint

with open('template.json') as f:
        template = json.loads(f)

pprint(template)

template["input_fastq_read1_files"] [0]
 

# def updateTemplate():
#         template = open("template.json", "r") # opens JSON template file for reading
#         data = json.load(template) # reads template into buffer
#         template.close() # closes template file

#         rd1_tmp = data["input_fastq_read1_files"]
#         rd2_tmp = data["input_fastq_read2_files"]
#         data["input_fastq_read1_files"] = rd1_path
#         data["input_fastq_read2_files"] = rd2_path

# read_path = '/data/scratch/rna-seq/RNASeq_Dec2018/*.fastq'
# read_files = glob.glob(read_path)

# for name in read_files: 
#     try:
#         with open(name) as f:
#             sys.stdout.write(f.read())
#     except IOError as exc:
#         if exc.errno != errno.EISDIR:
#             raise