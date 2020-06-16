#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

doc: |
  Worfklow combining an SRA fetch from NCBI with a fastq-dump cmd

requirements:
  MultipleInputFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  accession: string

steps:
  prefetch:
    in:
      accession: accession
    out:
      - sra_file
    run: ./prefetch.cwl

  fastq-dump:
    in:
      sra_file: prefetch/sra_file
      split_files:
        default: true
    out:
      - all_fastq_files
      - fastq_file_1
      - fastq_file_2
    run: ./fastq-dump.cwl

  rename_fastq1:
    in:
      srcfile: fastq-dump/fastq_file_1
      fastq2: fastq-dump/fastq_file_2
      accession: accession
      newname:
        valueFrom: |
          ${
            if (inputs.fastq2) {
              return inputs.srcfile.basename;
            } else {
              return inputs.accession + '.fastq';
            }
          }
    out:
      - outfile
    run: ./rename.cwl

outputs:
  fastq_files:
    type: File[]
    outputSource: fastq-dump/all_fastq_files
    format: edam:format_1931 # FASTQQ
  fastq_file_1:
    type: File
    outputSource: rename_fastq1/outfile
    format: edam:format_1931 # FASTQ
  fastq_file_2:
    type: File?
    outputSource: fastq-dump/fastq_file_2
    format: edam:format_1931 # FASTQ

$namespaces:
  edam: http://edamontology.org/
$schemas:
  - http://edamontology.org/EDAM_1.18.owl
