 class: CommandLineTool
 cwlVersion: v1.0
 hints:
    DockerRequirement:
      dockerPull: reddylab/overrepresented_sequence_extract:1.0
 inputs:
    input_fastqc_data:
      type: File
      inputBinding:
        position: 1
      doc: fastqc_data.txt file from a fastqc report
    input_basename:
      type: string
      doc: Name of the sample - used as a base name for generating output files
    default_adapters_file:
      type: File
      inputBinding:
        position: 2
      doc: Adapters file in fasta format
 outputs:
    output_custom_adapters:
      type: File
      outputBinding:
        glob: $(inputs.input_basename + '.custom_adapters.fasta')
    console_log:
      type: stdout
    error_log:
      type: stderr
 baseCommand: overrepresented_sequence_extract.py
 stdout: $(inputs.input_fastqc_data.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_overrepr_seq_extract_con.txt")
 stderr: $(inputs.input_fastqc_data.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_overrepr_seq_extract_err.txt")
 arguments:
  - valueFrom: $(inputs.input_basename + '.custom_adapters.fasta')
    position: 3
