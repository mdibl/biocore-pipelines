class: Workflow
cwlVersion: v1.0
id: bowtie2_workflow
label: bowtie2_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: genome_ref_first_index_file
    type: File
    'sbg:x': -592
    'sbg:y': -282
outputs:
  - id: tag.sample.timestamp.output_bowtie_log
    outputSource:
      - bowtie2/output_bowtie_log
    type: File
    'sbg:x': 25
    'sbg:y': -407
  - id: outfile
    outputSource:
      - bowtie2/outfile
    type: File
    'sbg:x': 31
    'sbg:y': -157
steps:
  - id: bowtie2
    in:
      - id: genome_ref_first_index_file
        source: genome_ref_first_index_file
    out:
      - id: outfile
      - id: output_bowtie_log
    run: rev_eng_ggr/map/bowtie2.cwl
    'sbg:x': -312
    'sbg:y': -281
requirements: []
