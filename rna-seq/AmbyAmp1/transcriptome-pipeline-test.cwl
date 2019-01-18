class: Workflow
cwlVersion: v1.0
id: transcriptome_pipeline_test
label: transcriptome-pipeline-test
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: input_read2_fastq_file
    type: 'File[]'
    'sbg:x': -388.95172119140625
    'sbg:y': -857.3443603515625
  - id: input_read1_fastq_file
    type: 'File[]'
    'sbg:x': -408.81158447265625
    'sbg:y': -652.9130249023438
  - id: default_adapters_file
    type: File
    'sbg:x': -384.6875305175781
    'sbg:y': -406.6197204589844
  - id: input_adapters_file
    type: File
    'sbg:x': 381.7313537597656
    'sbg:y': -850.7960205078125
outputs:
  - id: output_fastqc_report_files_read2
    outputSource:
      - 01_qc_pe/output_fastqc_report_files_read2
    type: 'File[]'
    'sbg:x': 138.56521606445312
    'sbg:y': -1205.23193359375
  - id: output_fastqc_report_files_read1
    outputSource:
      - 01_qc_pe/output_fastqc_report_files_read1
    type: 'File[]'
    'sbg:x': 143.53623962402344
    'sbg:y': -1088.608642578125
  - id: output_fastqc_data_files_read2
    outputSource:
      - 01_qc_pe/output_fastqc_data_files_read2
    type: 'File[]'
    'sbg:x': 145.15940856933594
    'sbg:y': -968.724609375
  - id: output_fastqc_data_files_read1
    outputSource:
      - 01_qc_pe/output_fastqc_data_files_read1
    type: 'File[]'
    'sbg:x': 137.82608032226562
    'sbg:y': -857.1448974609375
  - id: output_diff_counts_read2
    outputSource:
      - 01_qc_pe/output_diff_counts_read2
    type: 'File[]'
    'sbg:x': 139.21739196777344
    'sbg:y': -739.8115844726562
  - id: output_diff_counts_read1
    outputSource:
      - 01_qc_pe/output_diff_counts_read1
    type: 'File[]'
    'sbg:x': 148.69564819335938
    'sbg:y': -633.6666870117188
  - id: output_custom_adapters_read2
    outputSource:
      - 01_qc_pe/output_custom_adapters_read2
    type: 'File[]'
    'sbg:x': 145.4927520751953
    'sbg:y': -518.159423828125
  - id: output_custom_adapters_read1
    outputSource:
      - 01_qc_pe/output_custom_adapters_read1
    type: 'File[]'
    'sbg:x': 143.47825622558594
    'sbg:y': -401.5072326660156
  - id: output_count_raw_reads_read2
    outputSource:
      - 01_qc_pe/output_count_raw_reads_read2
    type: 'File[]'
    'sbg:x': 162.98550415039062
    'sbg:y': -280
  - id: output_count_raw_reads_read1
    outputSource:
      - 01_qc_pe/output_count_raw_reads_read1
    type: 'File[]'
    'sbg:x': 162.21739196777344
    'sbg:y': -164.10145568847656
steps:
  - id: 01_qc_pe
    in:
      - id: default_adapters_file
        source: default_adapters_file
      - id: input_read1_fastq_file
        source:
          - input_read1_fastq_file
      - id: input_read2_fastq_file
        source:
          - input_read2_fastq_file
    out:
      - id: output_count_raw_reads_read1
      - id: output_count_raw_reads_read2
      - id: output_custom_adapters_read1
      - id: output_custom_adapters_read2
      - id: output_diff_counts_read1
      - id: output_diff_counts_read2
      - id: output_fastqc_data_files_read1
      - id: output_fastqc_data_files_read2
      - id: output_fastqc_report_files_read1
      - id: output_fastqc_report_files_read2
    run: biocore-pipelines-dev/rna-seq/AmbyAmp1/01-qc-pe.cwl
    'sbg:x': -101.14492797851562
    'sbg:y': -693.8985595703125
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
    run: biocore-pipelines-dev/rna-seq/AmbyAmp1/trimmomatic.cwl
    'sbg:x': 540.9275512695312
    'sbg:y': -1077.3477783203125
requirements:
  - class: SubworkflowFeatureRequirement
