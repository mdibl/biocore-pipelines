cwlVersion: v1.0
class: CommandLineTool
baseCommand: [tar, -zcf]

requirements:
  -  class: InlineJavascriptRequirement
  -  class: InitialWorkDirRequirement
     listing: $(inputs.sourceFiles)

inputs:
  zipFileName:
  type: string
  inputBinding:
    position: 1

  sourceFiles:
    type: File[]
    inputBinding:
      separate: false
      position: 2
      valueFrom: |
        ${
            var r =[];
            for(var i=0; i < self.length; i++) {
                r.push(self[i].basename);
            }
        }

outputs:
  tarFile:
    type: File
    outputBinding:
      glob: $(inputs.zipFileName)