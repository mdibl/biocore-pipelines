class: CommandLineTool
cwlVersion: v1.0

doc: >
    "Scanpy is a scalable toolkit for analyzing single-cell gene expression data built jointly with anndata. 
    It includes preprocessing, visualization, clustering, trajectory inference and differential expression testing. 
    The Python-based implementation efficiently deals with datasets of more than one million cells."

label: 'Scanpy embed embeds cells into two-dimensional space'

hints:
  - class: DockerRequirement
    dockerPull: 'docker pull quay.io/biocontainers/scanpy-scripts:0.2.9--py_0'

baseCommand: [scanpy-cli, embed]

inputs:
  - id: umap
    type: string
    prefix: "umap"
    label: 'Embed the neighborhood graph using UMAP'
    
  - id: tsne
    type: string
    prefix: "tsne"
    label: 'Embed the cells using t-SNE'

  - id: fdg
    type: string
    prefix: "fdg"
    label: 'Embed the neighborhood graph using force-directed graph'

  - id: diffmap
    type: string
    prefix: "diffmap"
    label: 'Embed the neighborhood graph using diffisuion map'

# this is an odd script, and I think will be more appropriate as an auxiliary YAML file

  $schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
s:license: "https://www.gnu.org/licenses/gpl-3.0.en.html"
s:copyrightHolder: "MDIBL - MDI Biological Laboratory, 2020"
s:author: "Nathaniel Maki"