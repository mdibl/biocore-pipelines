 class: CommandLineTool
 cwlVersion: v1.0
 doc: Extracts read count from fastqc_data.txt
 hints:
    DockerRequirement:
      dockerPull: reddylab/workflow-utils:ggr
 inputs:
    input_fastqc_data:
      type: File
      inputBinding:
        position: 1
    input_basename:
      type: string
 outputs:
    output_fastqc_read_count:
      type: File
      outputBinding:
        glob: $(inputs.input_basename + '.fastqc-read_count.txt')
    console_log:
      type: stdout
    error_log:
      type: stderr
 baseCommand: count-fastqc_data-reads.sh
 stdout: count-fastqc-reads_out.txt
 stderr: count-fastqc-reads_err.txt
