class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
baseCommand:
  - fastqc
  - '-o'
stdout: $((inputs.input_fastq_file[0].basename)+"_console_log.txt")
stderr: $((inputs.input_fastq_file[0].basename)+"_error_log.txt")
inputs:
  - default: fastq
    id: format
    type: string
    inputBinding:
      position: 3
      prefix: '--format'
  - id: input_fastq_file
    type: File
    inputBinding:
      position: 4
  - default: true
    id: noextract
    type: boolean
    inputBinding:
      position: 2
      prefix: '--noextract'
  - default: 1
    id: threads
    type: int
    inputBinding:
      position: 5
      prefix: '--threads'
outputs:
  - id: output_qc_report_file
    type: File
    outputBinding:
      glob: >-
        $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/,
        "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_fastqc.zip")
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
    dockerPull: dukegcb/fastqc
requirements:
  - class: InlineJavascriptRequirement
