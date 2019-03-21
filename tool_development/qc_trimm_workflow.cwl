class: Workflow
cwlVersion: v1.0
id: qc_trimm_workflow
label: qc_trimm_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: input_read1_fastq_file
    type: File
    'sbg:x': -926
    'sbg:y': -676
  - id: input_adapters_file
    type: File
    'sbg:x': -935.076904296875
    'sbg:y': -513
  - id: input_read2_fastq_file
    type: File?
    'sbg:x': -945.076904296875
    'sbg:y': -850
outputs:
  - id: fastqc_result_read1
    outputSource:
      - fastqc_pitagora/fastqc_result
    type: 'File[]'
    'sbg:x': -353
    'sbg:y': -300
  - id: output_read2_trimmed_unpaired_file
    outputSource:
      - trimmomatic/output_read2_trimmed_unpaired_file
    type: File?
    'sbg:x': -308.9725036621094
    'sbg:y': -985.757080078125
  - id: output_read2_trimmed_paired_file
    outputSource:
      - trimmomatic/output_read2_trimmed_paired_file
    type: File?
    'sbg:x': -323
    'sbg:y': -868
  - id: output_read1_trimmed_unpaired_file
    outputSource:
      - trimmomatic/output_read1_trimmed_unpaired_file
    type: File?
    'sbg:x': -322.8858337402344
    'sbg:y': -737
  - id: output_read1_trimmed_file
    outputSource:
      - trimmomatic/output_read1_trimmed_file
    type: File
    'sbg:x': -314.4291687011719
    'sbg:y': -614
  - id: output_log_file
    outputSource:
      - trimmomatic/output_log_file
    type: File?
    'sbg:x': -313.4312744140625
    'sbg:y': -476.5433349609375
  - id: fastqc_result_read2
    outputSource:
      - fastqc_pitagora_1/fastqc_result
    type: 'File[]'
    'sbg:x': -341.484130859375
    'sbg:y': -107.19873046875
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
    'sbg:x': -628
    'sbg:y': -298
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
    'sbg:x': -615.57080078125
    'sbg:y': -107
requirements: []
