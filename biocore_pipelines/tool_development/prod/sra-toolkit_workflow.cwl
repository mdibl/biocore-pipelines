class: Workflow
cwlVersion: v1.0
id: sra_toolkit_workflow
label: SRA-toolkit_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs: []
outputs:
  - id: all_fastq_files
    outputSource:
      - fastq_dump/all_fastq_files
    type: 'File[]'
    'sbg:x': -204.02685546875
    'sbg:y': -291
  - id: fastq_file_1
    outputSource:
      - fastq_dump/fastq_file_1
    type: File
    'sbg:x': -224.02685546875
    'sbg:y': -428
  - id: fastq_file_2
    outputSource:
      - fastq_dump/fastq_file_2
    type: File?
    'sbg:x': -228
    'sbg:y': -551
steps:
  - id: prefetch
    in: []
    out:
      - id: console_log
      - id: error_log
      - id: sra_file
    run: ./prefetch.cwl
    label: Tool runs prefetch from NCBI SRA toolkit
    'sbg:x': -912.03125
    'sbg:y': -423
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
    'sbg:x': -568
    'sbg:y': -407
requirements: []
