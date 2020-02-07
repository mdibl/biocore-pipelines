cwlVersion: v1.0
class: CommandLineTool

doc: >
      "The package DESeq2 provides methods to test for differential expression by use of negative binomial generalized linear models;
      the estimates of dispersion and logarithmic fold changes incorporate data-driven prior distributions.
      Documentation can be found here: http://www.bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html"

label:  "The DESeq2 package uses the analysis of count data from high-throughput sequencing results to detect differential gene expression"

requirements:
  - class: InlineJavascriptRequirement
hints:
  DockerRequirement:
    dockerPull: docker pull quay.io/biocontainers/bioconductor-deseq2:1.26.0--r36he1b5a44_0
