class: CommandLineTool
cwlVersion: v1.0

doc: >
    "Scanpy is a scalable toolkit for analyzing single-cell gene expression data built jointly with anndata. 
    It includes preprocessing, visualization, clustering, trajectory inference and differential expression testing. 
    The Python-based implementation efficiently deals with datasets of more than one million cells."

label: 'Scanpy paga calculates diffusion pseudotime relative to the root cells'

hints:
  - class: DockerRequirement
    dockerPull: 'docker pull quay.io/biocontainers/scanpy-scripts:0.2.9--py_0'

baseCommand: [scanpy-cli, paga]

arguments:
  - prefix: '--output'
    valueFrom: $(runtime.outdir)/scanpy_out_dir/

inputs:
  - id: input-format
    type: string
    default: "anndata"
    inputBinding:
      position: 1
      prefix: '--input-format'
    label: 'Input object format [anndata|loom]'

  - id: output-format
    type: string
    default: "anndata"
    inputBinding:
      position: 2
      prefix: '--output-format'
    label: 'Output object format [anndata|loom|zarr]'

  - id: zarr-chunk-size
    type: int
    default: 1000
    inputBinding:
      position: 3
      prefix: '--zarr-chunk-size'
    label: 'Chunk size for writing outputs in zarr format'
  
  - id: export-mtx
    type: string
    inputBinding:
      position: 4
      prefix: '--export-mtx'
    label: 'When specified, use as prefix for exporting mtx files'
  
  - id: show-obj
    type: string
    default: "stdout"
    inputBinding:
      position: 5
      prefix: '--show-obj'
    label: 'Print output object summary info to specified stream [stdout|stderr]'
  
  - id: use-graph
    type: string
    default: "neighbors"
    inputBinding:
      position: 6
      prefix: '--use-graph'
    label: 'Slot under which '.uns' that contains the KNN graph of which sparse
            adjacency matrix is used for clustering'
  
  - id: key-added
    type: string
    inputBinding:
      position: 7
      prefix: '--key-added'
    label: 'Key under which to add the computed results'

  - id: root
    type: string
    default: "None, None"
    inputBinding:
      position: 8
      prefix: '--root'
    label: 'Specify a categorical annotation of observations and a value
            representing the root cells'

  - id: n-dcs
    type: int
    default: 10
    inputBinding:
      position: 9
      prefix: '--n-dcs'
    label: 'The number of diffusion components to use'
  
  - id: n-branchings
    type: int
    default: 0
    inputBinding:
      position: 10
      prefix: '--n-branchings'
    label: 'Number of branches to detect'

  - id: min-group-size
    type: float
    default: 0.01
    inputBinding:
      position: 11
      prefix: '--min-group-size'
    label: 'During recursive splitting of branches for --n-branchings > 1,
            do not consider branches/groups that contain fewer than this 
            fraction of total number of data points'
            
outputs:
  - id: output_obj
    type: File
    outputBinding:
      glob: "*."
    label: 'Output file in format specified by --output-format'

$schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
s:license: "https://www.gnu.org/licenses/gpl-3.0.en.html"
s:copyrightHolder: "MDIBL - MDI Biological Laboratory, 2020"
s:author: "Nathaniel Maki"