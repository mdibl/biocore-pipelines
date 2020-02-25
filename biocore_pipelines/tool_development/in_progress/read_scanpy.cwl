class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'

baseCommand: [scanpy-cli, read, --debug]

inputs:
  - id: input-10x-h5
    type: File
    inputBinding:
      position: 1
      prefix: '--input-10x-h5'
    label: 'input 10x data in Cell-Ranger hdf5 format'

  - id: input-10x-mtx
    type: Directory
    inputBinding:
      position: 2
      prefix: '--input-10x-mtx'
    label: 'path of input folder containing the 10x data in mtx format'
  
  - id: output-format
    type: string
    default: "anndata"
    inputBinding:
      position: 3
      prefix: '--output-format'
    label: 'output object format [anndata|loom|zarr]'
  
  - id: zarr-chunk-size
    type: int
    default: 1000
    inputBinding:
      position: 4
      prefix: '--zarr-chunk-size'
    label: 'chunk size for writing outputs in zarr format'
  
  - id: export-mtx
    type: string
    inputBinding:
      position: 5
      prefix: '--export-mtx'
    label: 'when specified, use as prefix for exporting mtx files'
  
  - id: show-obj
    type: string
    default: "stdout"
    inputBinding:
      position: 6
      prefix: '--show-obj'
    label: 'print output object summary info to specified stream [stdout|stderr]'
  
  - id: genome
    type: string
    default: "hg19"
    inputBinding:
      position: 7
      prefix: '--genome'
    label: 'name of genome group in hdf5 file, required by "--input-10x-h5"'
  
  - id: var-names
    type: string
    default: "gene_symbols"
    inputBinding:
      position: 8
      prefix: '--var-names'
    label: 'attribute to be used as the index of the variable table, required by "--input-10x-mtx" [gene_symbols|gene_ids]'

  - id: extra-obs
    type: File
    inputBinding:
      position: 9
      prefix: '--extra-obs'
    label: 'extra cell metadata table, must be TSV with header row, index column, and matched dimension'

  - id: extra-var
    type: File
    inputBinding:
      position: 10
      prefix: '--extra-var'
    label: 'extra gene metadata table, must be TSV with header row, index column, and matched dimension'

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

label: "Scanpy Reads takes in 10x data as input and saves it in a specified format"

hints:
  - class: DockerRequirement
    dockerPull: 'docker pull quay.io/biocontainers/scanpy-scripts:0.2.9--py_0'
$schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "MDIBL - MDI Biological Laboratory, 2020"
s:author: "Nathaniel Maki"
