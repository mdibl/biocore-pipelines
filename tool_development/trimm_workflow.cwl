class: Workflow
cwlVersion: v1.0
id: trimm_workflow
label: trimm_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: input_read2_fastq_file
    type: 'File[]'
    'sbg:x': -788
    'sbg:y': -421
  - id: input_read1_fastq_file
    type: 'File[]'
    'sbg:x': -784
    'sbg:y': -286
  - id: input_adapters_file
    type: File
    'sbg:x': -782
    'sbg:y': -122
outputs:
  - id: output_read2_trimmed_unpaired_file
    outputSource:
      - trimmomatic/output_read2_trimmed_unpaired_file
    type: File?
    'sbg:x': -275
    'sbg:y': -601
  - id: output_read2_trimmed_paired_file
    outputSource:
      - trimmomatic/output_read2_trimmed_paired_file
    type: File?
    'sbg:x': -254
    'sbg:y': -482
  - id: output_read1_trimmed_unpaired_file
    outputSource:
      - trimmomatic/output_read1_trimmed_unpaired_file
    type: File?
    'sbg:x': -275
    'sbg:y': -368
  - id: output_read1_trimmed_file
    outputSource:
      - trimmomatic/output_read1_trimmed_file
    type: File
    'sbg:x': -279
    'sbg:y': -229
  - id: output_log_file
    outputSource:
      - trimmomatic/output_log_file
    type: File?
    'sbg:x': -264
    'sbg:y': -81
steps:
  - id: trimmomatic
    in:
      - id: input_adapters_file
        source: input_adapters_file
      - id: input_read1_fastq_file
        source:
          - input_read1_fastq_file
      - id: input_read2_fastq_file
        source:
          - input_read2_fastq_file
    out:
      - id: output_error_file
      - id: output_log_file
      - id: output_read1_trimmed_file
      - id: output_read1_trimmed_unpaired_file
      - id: output_read2_trimmed_paired_file
      - id: output_read2_trimmed_unpaired_file
    run: ./trimmomatic.cwl
    label: >-
      Trimmomatic: A robust command line tool for trimming and cropping FASTQ
      data
    'sbg:x': -520
    'sbg:y': -279
requirements: []
