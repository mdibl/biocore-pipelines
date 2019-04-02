class: Workflow
cwlVersion: v1.0
id: qc_trimm_workflow
label: qc_trimm_workflow
inputs:
  - id: input_read2_fastq_file
    type: File[]
  - id: input_read1_fastq_file
    type: File[]
  - id: input_adapters_file
    type: File
outputs:
  - id: output_qc_report_file_2
    outputSource:
      - qc_workflow/output_qc_report_file_2
    type: File
  - id: output_qc_report_file
    outputSource:
      - qc_workflow/output_qc_report_file
    type: File
  - id: fastqc_result_2
    outputSource:
      - qc_workflow/fastqc_result_2
    type: File[]
  - id: fastqc_result
    outputSource:
      - qc_workflow/fastqc_result
    type: File[]
  - id: error_log_2
    outputSource:
      - qc_workflow/error_log_2
    type: stderr
  - id: error_log
    outputSource:
      - qc_workflow/error_log
    type: stderr
  - id: console_log_2
    outputSource:
      - qc_workflow/console_log_2
    type: stdout
  - id: console_log
    outputSource:
      - qc_workflow/console_log
    type: stdout
  - id: output_read2_trimmed_unpaired_file
    outputSource:
      - trimm_workflow/output_read2_trimmed_unpaired_file
    type: File?
  - id: output_read2_trimmed_paired_file
    outputSource:
      - trimm_workflow/output_read2_trimmed_paired_file
    type: File?
  - id: output_read1_trimmed_unpaired_file
    outputSource:
      - trimm_workflow/output_read1_trimmed_unpaired_file
    type: File?
  - id: output_read1_trimmed_file
    outputSource:
      - trimm_workflow/output_read1_trimmed_file
    type: File
  - id: output_log_file
    outputSource:
      - trimm_workflow/output_log_file
    type: File?
steps:
  - id: qc_workflow
    in:
      - id: input_read1_fastq_file
        source:
          - input_read1_fastq_file
      - id: input_read2_fastq_file
        source:
          - input_read2_fastq_file
    out:
      - id: output_qc_report_file
      - id: fastqc_result
      - id: error_log
      - id: console_log
      - id: output_qc_report_file_2
      - id: fastqc_result_2
      - id: error_log_2
      - id: console_log_2
    run: ./qc_workflow.cwl
    label: qc_workflow
  - id: trimm_workflow
    in:
      - id: input_read2_fastq_file
        source:
          - input_read2_fastq_file
      - id: input_read1_fastq_file
        source:
          - input_read1_fastq_file
      - id: input_adapters_file
        source: input_adapters_file
    out:
      - id: output_read2_trimmed_unpaired_file
      - id: output_read2_trimmed_paired_file
      - id: output_read1_trimmed_unpaired_file
      - id: output_read1_trimmed_file
      - id: output_log_file
    run: ./trimm_workflow.cwl
    label: trimm_workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: ScatterFeatureRequirement
  - class: StepInputExpressionRequirement
  - class: InlineJavascriptRequirement
  
