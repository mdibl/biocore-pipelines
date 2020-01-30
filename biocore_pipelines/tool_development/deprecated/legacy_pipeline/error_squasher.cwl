class: CommandLineTool
cwlVersion: v1.0

id: error_squasher
baseCommand: [tar, -zcf]

inputs:
 - id: file_pattern:
   type: string[]
   inputBinding:
     position: 2
     itemSeparator: "*"
     
 - id: output_file_name
  type: string
  inputBinding:
    position: 1

outputs:
 - id: tar_error_file
   type: File
   outputBinding:
     glob: output_file_name

