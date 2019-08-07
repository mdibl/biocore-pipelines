class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - samtools
  - sort
stdout: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_fastqc_con.txt")
stderr: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_fastqc_err.txt")
inputs:
  - id: input_bam
    type: File
    inputBinding:
      position: 50
  - default: 1
    id: nthreads
    type: int
    inputBinding:
      position: 1
      prefix: '-@'
  - default: sorted.bam
    id: output_filename
    type: string
outputs:
  - id: sorted_bamfile
    type: File
    outputBinding:
      glob: $(inputs.output_filename)
   console_log:
    type: stdout
   error_log: 
    type: stderr
arguments:
  - position: 3
    prefix: '-o'
    valueFrom: $(runtime.outdir)/$(inputs.output_filename)
  - position: 0
    prefix: '-m'
    valueFrom: 4G
  - position: 2
    prefix: '-O'
    valueFrom: bam
hints:
  - class: DockerRequirement
    dockerPull: 'quay.io/biocontainers/samtools:1.9--h46bd0b3_0'
requirements:
  - class: InlineJavascriptRequirement
