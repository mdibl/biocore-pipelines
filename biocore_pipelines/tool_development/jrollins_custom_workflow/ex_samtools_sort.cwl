class: CommandLineTool
cwlVersion: v1.0
hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/samtools:1.9--h46bd0b3_0
id: ex_samtools_sort
baseCommand:
  - samtools
  - sort
stdout: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_samsort_con.txt")
stderr: $(inputs.input_fastq_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_samsort_err.txt")
inputs:
  - id: alignment
    type: File?
    inputBinding:
      position: 0
outputs:
  - id: sorted_alignment
    type: File?
    outputBinding:
      glob: sorted_alignment.bam
    console_log:
     type: stdout
    error_log: 
     type: stderr
label: ex_samtools_sort
stdout: sorted_output.bam
