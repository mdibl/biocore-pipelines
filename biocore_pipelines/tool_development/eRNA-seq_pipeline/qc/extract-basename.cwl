 class: CommandLineTool
 cwlVersion: v1.0
 doc: Extracts the base name of a file
 requirements:
    InlineJavascriptRequirement: {}
 hints:
    DockerRequirement:
      dockerPull: reddylab/workflow-utils:ggr
 inputs:
    input_file:
      type: File
      inputBinding:
        position: 1
 outputs:
    output_basename:
      type: string
      outputBinding:
        outputEval: $(inputs.input_file.path.substr(inputs.input_file.path.lastIndexOf('/') + 1, inputs.input_file.path.lastIndexOf('.') - (inputs.input_file.path.lastIndexOf('/') + 1)))
    console_log:
      type: stdout
    error_log:
      type: stderr
 baseCommand: echo
 stdout: $(inputs.input_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_extract-basename_con.txt")
 stderr: $(inputs.input_file.path.replace(/^.*[\\\/]/, "").replace(/\.gz$/,"").replace(/\.[^/.]+$/, "") + "_extract-basename_err.txt")
