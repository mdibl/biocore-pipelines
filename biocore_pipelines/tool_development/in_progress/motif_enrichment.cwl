cwlVersion: v1.0
class: CommandLineTool

requirements:
- class:  InlineJavascriptRequirement

hints:
- class:  DockerRequirement
  dockerPull: # make docker repo of script, place here

inputs:

  read_motifs:
    type:
      - File
      - File[]
    inputBinding:
      position: 1
    doc: |
      Input for file that contains Position Weight Matrices

# TODO finish reading up on documentation for wrapping R
# experiment with rcwl
# test locally