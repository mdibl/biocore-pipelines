class: CommandLineTool
cwlVersion: v1.0

doc: >
    "Scanpy is a scalable toolkit for analyzing single-cell gene expression data built jointly with anndata. 
    It includes preprocessing, visualization, clustering, trajectory inference and differential expression testing. 
    The Python-based implementation efficiently deals with datasets of more than one million cells."

label: 'Scanpy norm normalises data per cell'

hints:
  - class: DockerRequirement
    dockerPull: 'docker pull quay.io/biocontainers/scanpy-scripts:0.2.9--py_0'

baseCommand: [scanpy-cli, norm]
stdout: $(inputs.input_obj.basename + "_norm-scanpy_console.txt")
stderr: $(inputs.input_obj.basename + "_norm-scanpy_error.txt")

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

  - id: save-raw
    type: string
    default: "yes"
    inputBinding:
      position: 6
      prefix: '--save-raw'
    label: 'Save raw data existing raw data [yes|no|counts]'
  
  - id: normalize-to
    type: float
    default: 10000
    inputBinding:
      position: 7
      prefix: '--normalize-to'
    label: 'Normalize per cell nUMI to this number'

  - id: fraction
    type: float
    default: 0.9
    inputBinding:
      position: 8
      prefix: '--fraction'
    label: 'Only use genes that make up less than this fraction of the total
            count in ever cell, only these enes will sum up to the number
            specified by --normalize-to'

  - id: input_obj
    type: File
    inputBinding:
      position: 10
    label: 'Input file in format specified by --input-format'

  outputs:
  - id: output_obj
    type: File
    outputBinding:
      glob: "*."
    label: 'Output file in format specified by --output-format'

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