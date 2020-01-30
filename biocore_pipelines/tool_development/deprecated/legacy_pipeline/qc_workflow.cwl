class: Workflow
cwlVersion: v1.0
id: qc_workflow
label: qc_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: input_read1_fastq_file
    type: File
  - id: input_read2_fastq_file
    type: File
outputs:
  - id: output_qc_report_file
    outputSource:
      - jr18_fastqc/output_qc_report_file
    type: File
  - id: error_log
    outputSource:
      - jr18_fastqc/error_log
    type: stderr
  - id: console_log
    outputSource:
      - jr18_fastqc/console_log
    type: stdout
  - id: output_qc_report_file_1
    outputSource:
      - jr18_fastqc_1/output_qc_report_file
    type: File
  - id: error_log_1
    outputSource:
      - jr18_fastqc_1/error_log
    type: stderr
  - id: console_log_1
    outputSource:
      - jr18_fastqc_1/console_log
    type: stdout
steps:
  - id: jr18_fastqc
    in:
      - id: input_fastq_file
        source: input_read1_fastq_file
    out:
      - id: console_log
      - id: error_log
      - id: output_qc_report_file
    run: ./jr18_fastqc.cwl
  - id: jr18_fastqc_1
    in:
      - id: input_fastq_file
        source: input_read2_fastq_file
    out:
      - id: console_log
      - id: error_log
      - id: output_qc_report_file
    run: ./jr18_fastqc.cwl
requirements: []
stderr: >-
  $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/,
  "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_fastqc_err.txt")
stdout: >-
  $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/,
  "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_fastqc_con.txt")
