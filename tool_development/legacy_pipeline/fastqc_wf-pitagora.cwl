class: Workflow
cwlVersion: v1.0
id: fastqc_wf_pitagora
label: fastqc_wf-pitagora
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: input_fastq_file
    type: 'File[]'
    'sbg:x': -624.0237426757812
    'sbg:y': -497
outputs:
  - id: fastqc_result
    outputSource:
      - fastqc_pitagora/fastqc_result
    type: 'File[]'
    'sbg:x': -192.02374267578125
    'sbg:y': -523
steps:
  - id: fastqc_pitagora
    in:
      - id: input_fastq_file
        source:
          - input_fastq_file
    out:
      - id: fastqc_result
    run: ./fastqc-pitagora.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -374
    'sbg:y': -439
requirements: []
