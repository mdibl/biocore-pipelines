class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'

baseCommand: [scanpy-cli, hvg, --debug]

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
    label: 'output object format [anndata|loom|zarr]'

  - id: zarr-chunk-size
    type: int
    default: 1000
    inputBinding:
      position: 3
      prefix: '--zarr-chunk-size'
    label: 'chunk size for writing outputs in zarr format'
  
  - id: export-mtx
    type: string
    inputBinding:
      position: 4
      prefix: '--export-mtx'
    label: 'when specified, use as prefix for exporting mtx files'
  
  - id: show-obj
    type: string
    default: "stdout"
    inputBinding:
      position: 5
      prefix: '--show-obj'
    label: 'print output object summary info to specified stream [stdout|stderr]'

  - id: mean-limits
    type: float
    default: 0.0125, 3
    inputBinding:
      position: 6
      prefix: '--mean-limits'
    label: 'cutoffs for the mean of expression in the format of "-m min max"'
  
  - id: disp-limits
    type: float
    default: 0.5, 
    inputBinding:
      position: 7
      prefix: '--disp-limits'
    label: 'cutoffs for the dispersion of expression in the format of "-d min max"'

  - id: n-bins
    type: int
    default: 20
    inputBinding:
      position: 8
      prefix: '--n-bins'
    label: 'number of bins for binning the mean gene expression'

  - id: n-top-genes
    type: int
    default: 2000
    inputBinding:
      position: 9
      prefix: '--n-top-genes'
    label: 'number of highly-variable genes to keep'

  - id: flavor
    type: string
    default: "seurat"
    inputBinding:
      position: 10
      prefix: '--flavor'
    label: choose flavor for computing normalized dispersion [seurat|cellranger]

  - id: subset
    type: boolean?
    inputBinding:
      prefix: '--subset'
    label: 'when set, inplace subset to highly-variable genes, otherwise only flag hvg'

  - id: by-batch
    type: string, int
    default: None, None
    inputBinding:
      position: 11
      prefix: '--by-batch'
    label: 'find highly variable genes within each batch defined by <text>
            then pool and keep those found in at least <integer> batches'

outputs:
  - id: output_obj
    type: File
    outputBinding:
      glob: "*."
    label: 'output file in format specified by --output-format'

doc: >
    "Scanpy is a scalable toolkit for analyzing single-cell gene expression data built jointly with anndata. 
    It includes preprocessing, visualization, clustering, trajectory inference and differential expression testing. 
    The Python-based implementation efficiently deals with datasets of more than one million cells."

label: 'Scanpy hvg finds highly variable genes'

arguments:
  - prefix: '--output'
    valueFrom: $(runtime.outdir)/scanpy_out_dir/

hints:
  - class: DockerRequirement
    dockerPull: 'docker pull quay.io/biocontainers/scanpy-scripts:0.2.9--py_0'
$schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
s:license: "https://www.gnu.org/licenses/gpl-3.0.en.html"
s:copyrightHolder: "MDIBL - MDI Biological Laboratory, 2020"
s:author: "Nathaniel Maki"