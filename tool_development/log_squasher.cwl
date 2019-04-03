class: CommandLineTool
cwlVersion: v1.0

id: log_squasher
baseCommand: [tar, -zcf]
inputs:
  - id: log_files
    type: File
    inputBinding:
      position: 0
      valueFrom: qc_log*.txt
outputs:
  - id: tar_log_files
    type: File?
    outputBinding:
      glob: '"qc_*logs.tar.gz"'
label: log_squasher
arguments:
  - position: 0
    prefix: ''
    valueFrom: '--wildcards'
