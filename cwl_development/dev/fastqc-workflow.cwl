cwlVersion: v1.0
class: Workflow
label: "A workflow wrapper for FastQC to allow for scattering on input files"
doc: >
    "Provides an additional layer of functionality over the underlying FastQC tool, 
    by letting a user submit a directory, or set of files to run FastQC on, without 
    having to manually create a new configuration for every unique single or set of sequence files"

requirements:
  ScatterFeatureRequirement: {}

inputs: file_array: File[]

steps:
  FastQC:
    run: ./FastQC.cwl
    scatter: seqfile
      in: 
        seqfile: file_array
      out: []

outputs: []
