class: CommandLineTool
cwlVersion: v1.0
hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/samtools:1.9--h46bd0b3_0

baseCommand: ["samtools", "index", "-b"]
stdout: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_samindex_con.txt")
stderr: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_samindex_err.txt")

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_bam)
inputs:
  input_bam:
    type: File
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  bam_index:
    type: File
    outputBinding:
      glob: "*bai"
  console_log:
    type: stdout
  error_log: 
    type: stderr
    
    