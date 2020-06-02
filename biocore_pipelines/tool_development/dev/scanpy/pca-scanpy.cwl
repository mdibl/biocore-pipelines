class: CommandLineTool
cwlVersion: v1.0

doc: >
    "Scanpy is a scalable toolkit for analyzing single-cell gene expression data built jointly with anndata. 
    It includes preprocessing, visualization, clustering, trajectory inference and differential expression testing. 
    The Python-based implementation efficiently deals with datasets of more than one million cells."

label: 'Scanpy pca displays dimensionality reduction by PCA'

hints:
  - class: DockerRequirement
    dockerPull: 'docker pull quay.io/biocontainers/scanpy-scripts:0.2.9--py_0'

baseCommand: [scanpy-cli, pca]

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

  - id: no-zero-center
    type: boolean?
    inputBinding:
      position: 6
      prefix: '--no-zero-center'
    label: 'When set, omit zero-centering variables to allow efficient handling of sparse input'
  
  - id: random-state
    type: int
    default: 0
    inputBinding:
      position: 7
      prefix: '--random-state'
    label: 'Seed for random number generator'
  
  - id: export-embedding
    type: File
    inputBinding:
      position: 8
      prefix: '--export-embedding'
    label: 'Export embeddings in a tab-separated text table'

  - id: n-comps
    type: int
    default: 50
    inputBinding:
      position: 9
      prefix: '--n-comps'
    label: 'Number of components to compute'

  - id: svd-solver
    type: string
    default: "auto"
    inputBinding:
      position: 10
      prefix: '--svd-solver'
    label: 'SVD solver to use [auto|arpack|randomized]'

  - id: use-all
    type: boolean?
    inputBinding:
      position: 11
      prefix: '--use-all'
    label: 'When set, use all genes for PCA, otherwise use HVG by default'

  - id: chunked
    type: boolean?
    inputBinding:
      position: 12
      prefix: '--chunked'
    label: 'When set, perform incremental PCA on segments of --chunk size
            automatically zero centers and ignores settigns of --random-state, --svd-solver'
  
  - id: chunk-size
    type: int
    inputBinding:
      position: 13
      prefix: '--chunk-size'
    label: 'Number of observations to inlcude in each chunk, required by --chunked'

outputs:
  - id: output_obj
    type: File
    outputBinding:
      glob: "*."
    label: 'Output file in format specified by --output-format'

$schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/version/latest/schema.rdf'
s:license: "https://www.gnu.org/licenses/gpl-3.0.en.html"
s:copyrightHolder: "MDIBL - MDI Biological Laboratory, 2020"
s:author: "Nathaniel Maki"