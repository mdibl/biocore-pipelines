class: CommandLineTool
cwlVersion: v1.0

id: log_squasher_v2
baseCommand: [tar, -zcf]

inputs:
 - id: error_files
   type: File
   inputBinding:
     position: 0
     valueFrom: *_fastqc_err.txt

outputs:
 - id: tar_error_files
   type: File
   outputBinding:
     glob: "*_fastqc_err.tar.gz"

label: error_squasher
arguments:
 - position: 0
   prefix: ''
   valueFrom: '--wildcards' 