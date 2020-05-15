cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/samtools:1.9--h46bd0b3_0

baseCommand: ["samtools", "index", "-b"]

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
  
stdout: $(inputs.input_bam.basename + "_samtools_index_bam_console.txt")
stderr: $(inputs.input_bam.basename + "_samtools_index_bam_error.txt")

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/
s:copyrightHolder: "MDI Biological Laboratory, 2020"
s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:codeRepository: https://github.com/mdibl/biocore_analysis
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0003-3777-5945
    s:email: mailto:inutano@gmail.com
    s:name: Tazro Ohta
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9120-8365
    s:email: mailto:nmaki@mdibl.org
    s:name: Nathaniel Maki

$schemas:
  - https://schema.org/docs/schema_org_rdfa.html
  - http://edamontology.org/EDAM_1.18.owl
