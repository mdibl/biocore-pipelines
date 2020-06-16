cwlVersion: v1.0
class: CommandLineTool
label: "Conducts differential gene expression analysis based upon negative binomial distribution"
doc:

requirements:
- class: InlineJavascriptRequirement

hints:
- class: DockerRequirement:
    dockerPull: quay.io/biocontainers/bioconductor-deseq2:1.20.0--r351hfc679d8_0