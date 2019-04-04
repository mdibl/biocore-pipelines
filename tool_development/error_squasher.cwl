class: CommandLineTool
cwlVersion: v1.0

id: error_squasher
baseCommand: [tar, -czf]

inputs:
 - id: error_files
   type: File
   inputBinding:
     position: 0
     valueFrom: qc_error_log.txt

outputs:
 - id: tar_error_files
   type: File
   outputBinding:
     glob: $(outputs.error_files)

label: error_squasher
arguments:
 - position: 0
   prefix: ''
   valueFrom: '--wildcards' 