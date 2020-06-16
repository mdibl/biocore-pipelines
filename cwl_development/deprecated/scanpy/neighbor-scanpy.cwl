class: CommandLineTool
cwlVersion: v1.0

doc: >
    "Scanpy is a scalable toolkit for analyzing single-cell gene expression data built jointly with anndata. 
    It includes preprocessing, visualization, clustering, trajectory inference and differential expression testing. 
    The Python-based implementation efficiently deals with datasets of more than one million cells."

label: 'Scanpy neighbor computes a neighbourhood graph of observations'

hints:
  - class: DockerRequirement
    dockerPull: 'docker pull quay.io/biocontainers/scanpy-scripts:0.2.9--py_0'

baseCommand: [scanpy-cli, neighbor]

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

  - id: n-pcs
    type: int
    inputBinding:
      position: 6
      prefix: '--no-pcs'
    label: 'Use this many PCs. Use '.X' if --n-pcs is 0 when --use-rep is None'
  
  - id: use-rep
    type: string
    inputBinding:
      position: 7
      prefix: '--use-rep'
    label: 'Use the indicated representation, if None, chosen automatically'
  
  - id: key-added
    type: string
    inputBinding:
      position: 8
      prefix: '--key-added'
    label: 'Key under which to add computed results'

  - id: random-state
    type: int
    default: 0
    inputBinding:
      position: 9
      prefix: '--random-state'
    label: 'Seed for random number generator'

  - id: n-neighbors
    type: int
    default: 15
    inputBinding:
      position: 10
      prefix: '--n-neighbors'
    label: 'Size of local neighbourhood used for manifold approximation'

  - id: no-knn
    type: boolean
    default: True
    inputBinding:
      position: 11
      prefix: '--no-knn'
    label: 'When NOT set, use hard threshold to restrict number of neighbors
            to --n-neighbors. Otherwise, use Gk to assign low weights to distant
            neighbors' 

  - id: method
    type: string
    default: "umap"
    inputBinding:
      position: 12
      prefix: --method
    label: 'Use umap or gauss with adaptive width for computing connectivities [umap}gauss]'

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