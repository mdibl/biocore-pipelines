import json
import sys
import glob
import errno
import os
import pprint
import fileinput

# lists all files with .fastq filetype in given directory
# for file in os.listdir('/data/scratch/rna-seq/JimCoffman/RNASeq_Dec2018/'):
#     if file.endswith(".fastq"):
#         print(
#             os.path.join("/data/scratch/rna-seq/JimCoffman/RNASeq_Dec2018", file))

template_path = '/data/projects/Biocore/biocore-pipelines/rna-seq/json_generator/*.json'
jason_template = glob.glob(template_path)

# creates text file containing read names in the sample directory 
with open("read_list.txt", "w") as rl:
    for path, subdirs, files in os.walk(r'/data/scratch/rna-seq/JimCoffman/RNASeq_Dec2018'):
        for filename in files:
            f = os.path.join(filename)
            rl.write(str(f) + os.linesep)
    # lines = rl.readlines()
    # lines.sort()

# open design file and loads into memory
design_file = open('Sample_DF_JR08-18.txt', 'r')
contents = design_file.read()
print(contents)
design_file.close()

# load samples with corresponding read files into dictionary
# samples={}
# for each line in design file:
#     fields=split("\t",line)
#     sample_id=field[0]
#     samples[sample_id]={}
#     #get list of reads files for this sample_id from experiment_base_dir
#     reads=glob.glob("path2reads/sample_id*)
#     #get read1_file
#     #get read2_file
#     #update json_template.read1_file=path2reads/read1_file
#     #update json_template.read2_file=path2reads/read2_file
#     #generate this sample_id.json file from json_template object

samples = {}
read_path = '/data/scratch/rna-seq/JimCoffman/RNASeq_Dec2018/*.fastq'
read_files = glob.glob(read_path)

with open('Sample_DF_JR08-18.txt', 'r') as design_file:
    for line in design_file:
        field = line.split("\t", 0)
        sample_id = field[0]
        samples[sample_id] = {}
        # get list of read files for specific sample_id from experiment_base_dir

        reads = glob.glob(read_path + sample_id)
        
# load json file into a dict

# def js_r(filename):
#     r = json.load(open('template.json'), object_pairs_hook=OrderedDict)
#         print json.dumps(r, indent=2)


# if __name__ == "__main__":
#     my_data = js_r('template.json')
#     print(my_data)

# loads json files into an array and displays content
# template_array = []
# with open('template.json') as my_file:
#         for line in my_file:
#                 template_array.append(line)

from pprint import pprint

with open('template.json') as f:
    template = json.load(f)

pprint(template)

# parse json content to an object

# class JParse(object):
#     def __init__(self, data):
#         self.__dict__ = json.loads('template.json')

# parse = JParse('template.json')
# print(parse)


# convert json to python object

# class Template:
#     def __init__(self, input_fastq_read1_files, input_fastq_read2_files):
#         self.input_fastq_read1_files = input_fastq_read1_files
#         self.input_fastq_read2_files = input_fastq_read2_files

# j = json.loads('{"input_fastq_read1_files":"/data/scratch/rna-seq/RNASeq_Dec2018/*.fastq"}')
# pythonObj = Template(**j)

# print(pythonObj.input_fastq_read1_files)
# print(pythonObj.input_fastq_read2_files)

# function to traverse deeply nested structures in json


def traverse(obj, path=None, callback=None):
    if path is None:
        path = []

    if isinstance(obj, dict):
        value = {k: traverse(v, path + [k], callback) for k, v in obj.items()}
    elif isinstance(obj, list):
        value = [traverse(elem, path + [[]], callback) for elem in obj]
    else:
        value = obj

    if callback is None:  # if a callback is provided, call it to get the new value
        return value
    else:
        return callback(path, value)


# traversal modification function
# def traverse_modify(obj, target_path, action):
#     # fix me pls, give me a
#     target_path = to_path(target_path)

#     # below component will get called every path/value in structure
#     def transformer(path, value):
#         if path == target_path:
#             return action(value)
#         else:
#             return value

#     return traverse(obj, callback=transformer)

# from operator import itemgetter

# def sort_points(points):
#     return sorted(points, reverse=True, key=itemgetter('stop'))

# fix me pls
# traverse_modify(doc, 'res[].catlist[].points', sort_points)

# update json values
# if os.path.exists(
#         '/data/projects/Biocore/biocore-pipelines/rna-seq/json_generator/template.json'
# ):
#     with open(
#             '/data/projects/Biocore/biocore-pipelines/rna-seq/json_generator/template.json',
#             'r+') as tf:
#         jtemp = json.load(tf)
#         # update json
#         tf.seek(0)
#         tf.truncate()
#         json.dump(jtemp, tf)

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
