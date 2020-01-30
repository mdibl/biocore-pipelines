class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: pipeline_pe_unstranded
baseCommand:
  - tar
  - '-zcf'
inputs:
  - id: prefix_files
    type: File
    inputBinding:
      position: 0
      prefix: ''
      valueFrom: qc_*log.txt
outputs:
  - id: tar_output
    type: File
    outputBinding:
      glob: '"qc_*log.tar.gz"'
doc: >-
  log_squasher takes all *log.txt file with appropriate prefix and compresses
  them into a zipped tarball
label: log_squasher
requirements:
  - class: ResourceRequirement
    ramMin: 8000
    coresMin: 4
