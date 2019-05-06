class: Workflow
cwlVersion: v1.0
id: fastqc_workflow
label: fastqc_workflow
inputs:
  - id: input_fastq_file
    type: File
outputs:
  - id: output_qc_report_file
    outputSource:
      - fastqc/output_qc_report_file
    type: File
  - id: fastqc_error_log
    outputSource:
      - fastqc/fastqc_error_log
    type: File
  - id: fastqc_console_log
    outputSource:
      - fastqc/fastqc_console_log
    type: File
  - id: cmd_console_log
    outputSource:
      - cmd/cmd_console_log
    type: File
  - id: cmd_error_log
    outputSource:
      - cmd/cmd_error_log
    type: File
steps:
  - id: fastqc
    in:
      - id: input_fastq_file
        source: input_fastq_file
    out:
      - id: fastqc_console_log
      - id: fastqc_error_log
      - id: output_qc_report_file
    run: ./fastqc.cwl
  - id: cmd
    in:
      - id: input_fastq_file
        source: input_fastq_file
    out:
      - id: cmd_console_log
      - id: cmd_error_log
    run: ./cmd2.cwl
requirements:
  - class: InlineJavascriptRequirement
