#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
label: "Tool runs prefetch from NCBI SRA toolkit"
doc: "The SRA Toolkit and SDK from NCBI is a collection of tools and libraries for using data in the INSDC Sequence Read Archives"

hints:
  DockerRequirement:
    dockerPull: inutano/sra-toolkit

baseCommand: [prefetch]

arguments: ["-O", '.']

inputs:
  accession:
    label: "SRA read accession"
    type: string
    inputBinding:
      position: 4
  transport:
    label: "Transport protocol to use, 'fasp', 'http', or 'both'"
    type: string?
    inputBinding:
      position: 3
      prefix: '-t'

outputs:
  sra_file:
    type: File
    outputBinding:
      glob: $(inputs.accession)/$(inputs.accession).sra

  console_log:
    type: stdout
  error_log:
    type: stderr

stdout: prefetch_console.txt
stderr: prefetch_error.txt
$namespaces:
  s: http://schema.org/

$schemas:
- http://schema.org/version/latest/schema.rdf

s:name: "prefetch"
s:license: http://www.apache.org/licenses/LICENSE-2.0

s:isPartOf:
  class: s:CreativeWork
  s:name: Common Workflow Language
  s:url: http://commonwl.org/

s:creator:
- class: s:Organization
  s:legalName: "Cincinnati Children's Hospital Medical Center"
  s:location:
  - class: s:PostalAddress
    s:addressCountry: "USA"
    s:addressLocality: "Cincinnati"
    s:addressRegion: "OH"
    s:postalCode: "45229"
    s:streetAddress: "3333 Burnet Ave"
    s:telephone: "+1(513)636-4200"
  s:logo: "https://www.cincinnatichildrens.org/-/media/cincinnati%20childrens/global%20shared/childrens-logo-new.png"
  s:department:
  - class: s:Organization
    s:legalName: "Allergy and Immunology"
    s:department:
    - class: s:Organization
      s:legalName: "Barski Research Lab"
      s:member:
      - class: s:Person
        s:name: Michael Kotliar
        s:email: mailto:misha.kotliar@gmail.com
        s:sameAs:
        - id: http://orcid.org/0000-0002-6486-3898
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9120-8365
    s:email: mailto:nmaki@mdibl.org
    s:name: Nathaniel Maki
