class: Workflow
cwlVersion: v1.0
id: qc_trimm_workflow
label: qc_trimm_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: input_read1_fastq_file
    type: File
    'sbg:x': -938
    'sbg:y': -669.7805786132812
  - id: input_adapters_file
    type: File
    'sbg:x': -931.3966064453125
    'sbg:y': -484.87762451171875
  - id: input_read2_fastq_file
    type: File?
    'sbg:x': -935.50634765625
    'sbg:y': -841.5611572265625
outputs:
  - id: fastqc_result_read1
    outputSource:
      - fastqc_pitagora/fastqc_result
    type: 'File[]'
    'sbg:x': -454
    'sbg:y': -409
  - id: output_read2_trimmed_unpaired_file
    outputSource:
      - trimmomatic/output_read2_trimmed_unpaired_file
    type: File?
    'sbg:x': -264
    'sbg:y': -960
  - id: output_read2_trimmed_paired_file
    outputSource:
      - trimmomatic/output_read2_trimmed_paired_file
    type: File?
    'sbg:x': -273
    'sbg:y': -841
  - id: output_read1_trimmed_unpaired_file
    outputSource:
      - trimmomatic/output_read1_trimmed_unpaired_file
    type: File?
    'sbg:x': -276
    'sbg:y': -724
  - id: output_read1_trimmed_file
    outputSource:
      - trimmomatic/output_read1_trimmed_file
    type: File
    'sbg:x': -272
    'sbg:y': -608
  - id: output_log_file
    outputSource:
      - trimmomatic/output_log_file
    type: File?
    'sbg:x': -273
    'sbg:y': -489
  - id: fastqc_result_read2
    outputSource:
      - fastqc_pitagora_1/fastqc_result
    type: 'File[]'
    'sbg:x': -483
    'sbg:y': -956
steps:
  - id: fastqc_pitagora
    in:
      - id: input_fastq_file
        source:
          - input_read1_fastq_file
    out:
      - id: fastqc_result
    run: ./fastqc-pitagora.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -672
    'sbg:y': -442
  - id: trimmomatic
    in:
      - id: input_adapters_file
        source: input_adapters_file
      - id: input_read1_fastq_file
        source: input_read1_fastq_file
      - id: input_read2_fastq_file
        source: input_read2_fastq_file
    out:
      - id: output_log_file
      - id: output_read1_trimmed_file
      - id: output_read1_trimmed_unpaired_file
      - id: output_read2_trimmed_paired_file
      - id: output_read2_trimmed_unpaired_file
    run: trimmomatic/trimmomatic.cwl
    label: >-
      Trimmomatic: A robust command line tool for trimming and cropping FASTQ
      data
    'sbg:x': -592
    'sbg:y': -666
  - id: fastqc_pitagora_1
    in:
      - id: input_fastq_file
        source:
          - input_read2_fastq_file
    out:
      - id: fastqc_result
    run: ./fastqc-pitagora.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -656
    'sbg:y': -913
requirements: []
