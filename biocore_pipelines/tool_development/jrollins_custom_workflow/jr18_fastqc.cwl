class: CommandLineTool
cwlVersion: v1.0
baseCommand: fastqc
stdout: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_fastqc_con.txt")
stderr: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_fastqc_err.txt")
inputs:
  format: 
    default: fastq
    type: string
    inputBinding:
      position: 3
      prefix: '--format'
  input_fastq_file:
    type: File
    inputBinding:
      position: 4
  threads:
    default: 1
    type: int
    inputBinding:
      position: 5
      prefix: '--threads'
outputs:
  output_qc_report_file:
    type: File
    outputBinding:
      glob: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_fastqc.zip")
  console_log:
    type: stdout
  error_log: 
    type: stderr
arguments:
  - position: 5
    prefix: '--dir'
    valueFrom: $(runtime.tmpdir)
  - position: 5
    prefix: '-o'
    valueFrom: $(runtime.outdir)
hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/fastqc:0.11.7--pl5.22.0_2'
requirements:
  - class: InlineJavascriptRequirement
