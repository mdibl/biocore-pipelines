class: CommandLineTool
cwlVersion: v1.0
baseCommand: ls 
stdout: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_ls_con.txt")
stderr: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_ls_err.txt")
inputs:
  input_fastq_file:
    type: File
    inputBinding:
      position: 4
outputs:
  console_log:
    type: stdout
  error_log: 
    type: stderr
requirements:
  - class: InlineJavascriptRequirement
