 class: CommandLineTool
 cwlVersion: v1.0
 #requirements:
    #InlineJavascriptRequirement: {}
 hints:
    DockerRequirement:
      dockerPull: dukegcb/fastqc
 inputs:
    format:
      type: string
      default: fastq
      inputBinding:
        position: 3
        prefix: --format
    threads:
      type: int
      default: 1
      inputBinding:
        position: 5
        prefix: --threads
    noextract:
      type: boolean
      default: true
      inputBinding:
        prefix: --noextract
        position: 2
    input_fastq_file:
      type: File
      inputBinding:
        position: 4
 outputs:
    output_qc_report_file:
      type: File
      outputBinding:
        glob: "*_fastqc.zip"
    console_log:
      type: stdout
    error_log: 
      type: stderr
 baseCommand: fastqc
 stdout: $(inputs.input_fastq_file.basename).fastqc.txt
 stderr: $(inputs.input_fastq_file.basename).fastqc_error_log.txt
 arguments:
  - valueFrom: $(runtime.tmpdir)
    prefix: --dir
    position: 5
  - valueFrom: $(runtime.outdir)
    prefix: -o
    position: 5
