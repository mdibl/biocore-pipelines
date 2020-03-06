class: CommandLineTool
cwlVersion: v1.0

doc: >
    "Scanpy is a scalable toolkit for analyzing single-cell gene expression data built jointly with anndata. 
    It includes preprocessing, visualization, clustering, trajectory inference and differential expression testing. 
    The Python-based implementation efficiently deals with datasets of more than one million cells."

label: 'Scanpy Filter filters data based on specified conditions'

hints:
  - class: DockerRequirement
    dockerPull: 'docker pull quay.io/biocontainers/scanpy-scripts:0.2.9--py_0'

baseCommand: [scanpy-cli, filter]

stdout: $(inputs.input_obj.basename + "_filter-scanpy_console.txt")
stderr: $(inputs.input_obj.basename + "_filter-scanpy_error.txt")

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
  
  - id: gene-name
    type: string
    default: "index"
    inputBinding:
      position: 6
      prefix: '--gene-name'
    label: 'name of the variable that contains gene names, used for flagging mitochondria genes'
  
  - id: list-attr
    type: boolean?
      prefix: '--list-attr'
    label: 'list attributes that can be filtered on'
  
  - id: param
    type: string, float
    inputBinding:
      position: 7
      prefix: '--param'
    label: 'numerical parameters used to filter the data, in the format of "-p name min max"'
  
  - id: category
    type: string
    inputBinding:
      position: 8
      prefix: '--category'
    label: 'categorical attributes used to filter the data in format of
            "-c <name> <values>", where entries with <name> attribute with value in <values> are kept'
  
  - id: subset 
    type: string
    inputBinding:
      position: 9
      prefix: '--subset'
    label: 'similar to --category in format of -s <name> <file>'

  - id: input_obj
    type: File
    inputBinding:
      position: 10
    label: 'input file in format specified by --input-format'

outputs:
  - id: output_obj
    type: File
    outputBinding:
      glob: "*."
    label: 'output file in format specified by --output-format'

  - id: console_log:
    type: stdout

  - id: error_log:
    type: stderr

$schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'
s:license: "https://www.gnu.org/licenses/gpl-3.0.en.html"
s:copyrightHolder: "MDIBL - MDI Biological Laboratory, 2020"
s:author: "Nathaniel Maki"