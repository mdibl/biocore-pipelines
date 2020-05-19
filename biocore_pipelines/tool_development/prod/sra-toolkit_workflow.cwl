class: Workflow
cwlVersion: v1.0
id: sra_toolkit_workflow
label: SRA-toolkit_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs: []
outputs:
  - id: console_log
    outputSource:
      - prefetch/console_log
    type: stdout
    'sbg:x': -543.3968505859375
    'sbg:y': 88
  - id: error_log
    outputSource:
      - prefetch/error_log
    type: stderr
    'sbg:x': -490.3968505859375
    'sbg:y': -25
  - id: fastq_file_2
    outputSource:
      - fastq_dump/fastq_file_2
    type: File?
    'sbg:x': 7
    'sbg:y': -493
  - id: fastq_file_1
    outputSource:
      - fastq_dump/fastq_file_1
    type: File
    'sbg:x': 27
    'sbg:y': -345
  - id: error_log_1
    outputSource:
      - fastq_dump/error_log
    type: stderr
    'sbg:x': 22
    'sbg:y': -196
  - id: console_log_1
    outputSource:
      - fastq_dump/console_log
    type: stdout
    'sbg:x': 20
    'sbg:y': -72
  - id: all_fastq_files
    outputSource:
      - fastq_dump/all_fastq_files
    type: 'File[]'
    'sbg:x': 13
    'sbg:y': 54
steps:
  - id: prefetch
    in: []
    out:
      - id: console_log
      - id: error_log
      - id: sra_file
    run: ./prefetch.cwl
    label: Tool runs prefetch from NCBI SRA toolkit
    'sbg:x': -676
    'sbg:y': -155
  - id: fastq_dump
    in:
      - id: sra_file
        source: prefetch/sra_file
    out:
      - id: all_fastq_files
      - id: console_log
      - id: error_log
      - id: fastq_file_1
      - id: fastq_file_2
    run: ./fastq-dump.cwl
    'sbg:x': -199.3968505859375
    'sbg:y': -136
requirements: []
