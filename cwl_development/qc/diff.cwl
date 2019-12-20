 class: CommandLineTool
 cwlVersion: v1.0
 doc: Compares 2 files
 hints:
    DockerRequirement:
      dockerPull: reddylab/workflow-utils:ggr
 inputs:
    file2:
      type: File
      inputBinding:
        position: 2
    file1:
      type: File
      inputBinding:
        position: 1
    brief:
      type: boolean
      default: true
      inputBinding:
        prefix: --brief
        position: 3
 outputs:
    result:
      type: File
      outputBinding:
        glob: stdout.txt
    diff_error_log:
      type: File
 baseCommand: diff
 stdout: diff_stdout.txt
