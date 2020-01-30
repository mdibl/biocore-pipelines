class: Workflow
cwlVersion: v1.0
id: fastqc_pipeline
label: fastqc_pipeline
inputs:
  - id: input_fastq_file
    type: File
outputs:
  - id: output_qc_report_file
    outputSource:
      - fastqc_workflow/fastqc/output_qc_report_file
    type: File
  - id: fastqc_error_log
    outputSource:
      - fastqc_workflow/fastqc/fastqc_error_log
    type: File
  - id: fastqc_console_log
    outputSource:
      - fastqc_workflow/fastqc/fastqc_console_log
    type: File
steps:
  - id: fastqc_workflow/fastqc
    in:
      - id: input_fastq_file
        source: input_fastq_file
    out:
      - id: fastqc_console_log
      - id: fastqc_error_log
      - id: output_qc_report_file
    run: ./fastqc.cwl
requirements:
  - class: InlineJavascriptRequirement