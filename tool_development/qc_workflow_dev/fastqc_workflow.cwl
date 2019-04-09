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
 # - id: error_log
  #  outputSource:
   #   - fastqc/error_log
   # type: stderr
 # - id: console_log
  #  outputSource:
   #   - fastqc/console_log
   # type: stdout
steps:
  - id: fastqc
    in:
      - id: input_fastq_file
        source: input_fastq_file
    out:
     # - id: console_log
     # - id: error_log
      - id: output_qc_report_file
    run: ./fastqc.cwl
requirements:
  - class: InlineJavascriptRequirement
