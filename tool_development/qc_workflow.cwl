class: Workflow
cwlVersion: v1.0
id: qc_workflow
label: qc_workflow
stdout: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_fastqc_con.txt")
stderr: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_fastqc_err.txt")
5$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: input_read1_fastq_file
    type: 'File[]'
    'sbg:x': -765.8374633789062
    'sbg:y': -323.1684265136719
  - id: input_read2_fastq_file
    type: 'File[]'
    'sbg:x': -706
    'sbg:y': 186
outputs:
  - id: output_qc_report_file
    outputSource:
      - fastqc_pitagora/output_qc_report_file
    type: File
    'sbg:x': -164
    'sbg:y': -547
  - id: fastqc_result
    outputSource:
      - fastqc_pitagora/fastqc_result
    type: 'File[]'
    'sbg:x': -156
    'sbg:y': -427
  - id: error_log
    outputSource:
      - fastqc_pitagora/error_log
    type: file[]
    'sbg:x': -152
    'sbg:y': -313
  - id: console_log
    outputSource:
      - fastqc_pitagora/console_log
    type: file[]
    'sbg:x': -147
    'sbg:y': -134
  - id: output_qc_report_file_2
    outputSource:
      - fastqc_pitagora_1/output_qc_report_file
    type: File
    'sbg:x': -140
    'sbg:y': 18
  - id: fastqc_result_2
    outputSource:
      - fastqc_pitagora_1/fastqc_result
    type: 'File[]'
    'sbg:x': -137
    'sbg:y': 136
  - id: error_log_2
    outputSource:
      - fastqc_pitagora_1/error_log
    type: file[]
    'sbg:x': -132
    'sbg:y': 270
  - id: console_log_2
    outputSource:
      - fastqc_pitagora_1/console_log
    type: file[]
    'sbg:x': -129
    'sbg:y': 427
steps:
  - id: fastqc_pitagora
    in:
      - id: input_read_files
        source:
          - input_read1_fastq_file
    out:
      - id: console_log
      - id: error_log
      - id: fastqc_result
      - id: output_qc_report_file
    run: ./fastqc-pitagora.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -452
    'sbg:y': -351
  - id: fastqc_pitagora_1
    in:
      - id: input_read_files
        source:
          - input_read2_fastq_file
    out:
      - id: console_log
      - id: error_log
      - id: fastqc_result
      - id: output_qc_report_file
    run: ./fastqc-pitagora.cwl
    label: 'FastQC: A quality control tool for high throughput sequence data'
    'sbg:x': -423
    'sbg:y': 186
requirements: []
