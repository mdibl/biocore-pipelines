cwlVersion: v1.0
class: CommandLineTool
baseCommand: zip

requirements:

  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.srcFiles)

inputs:

  zipFileName:
    type: string
    inputBinding:
      position: 1

  srcFiles:
    inputBinding:
      position: 2
    type:
      type: array
      items: File
    inputBinding:
      valueFrom: $(self.basename)
      
      

outputs:
  zipFile:
    type: File
    outputBinding:
      glob: $(inputs.zipFileName)