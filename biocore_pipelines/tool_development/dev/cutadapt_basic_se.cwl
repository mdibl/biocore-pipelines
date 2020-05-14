cwlVersion: v1.0
class: CommandLineTool
label: "Cutadapt finds and removes adapter sequences, primers, poly-A tail from HTS results"
doc: "Cutadapt finds and removes adapter sequences, primers, 
      poly-A tails and other types of unwanted sequence from your high-throughput sequencing reads.
      Current documentation can be found here: https://cutadapt.readthedocs.io/en/stable/"

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/cutadapt:1.18--py35_0

baseCommand: ["cutadapt"]