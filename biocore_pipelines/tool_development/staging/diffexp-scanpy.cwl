class: CommandLineTool
cwlVersion: v1.0

doc: >
    "Scanpy is a scalable toolkit for analyzing single-cell gene expression data built jointly with anndata. 
    It includes preprocessing, visualization, clustering, trajectory inference and differential expression testing. 
    The Python-based implementation efficiently deals with datasets of more than one million cells."

label: 'Scanpy diffexp finds markers for each cluster(s)'

hints:
  - class: DockerRequirement
    dockerPull: 'docker pull quay.io/biocontainers/scanpy-scripts:0.2.9--py_0'

baseCommand: [scanpy-cli, diffexp]

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

  - id: use-raw
    type: boolean
    default: True
    inputBinding:
      position: 6
      prefix: '--use-raw'
    label: 'Use expression values in '.raw' if present'

  - id: groupby
    type: string
    inputBinding:
      position: 7
      prefix: '--groupby'
    label: 'The key of the observations grouping to consider'
  
  - id: groups
    type: string
    default: "all"
    inputBinding:
      position: 8
      prefix: '--groups'
    label: 'Subset of groups to which comparison shall be restricted'

  - id: reference
    type: string
    default: "rest"
    inputBinding:
      position: 9
      prefix: '--reference'
    label: 'If "rest", compare each group to the union of rest of groups. If group id
            compare with respect to this group'
  
  - id: n-genes
    type: int
    inputBinding:
      position: 10
      prefix: '--n-genes'
    label: 'The number of genes that appear in the returned tables. By default depend
            on value of --use-raw'
  
  - id: method
    type: string
    default: "t-test_overestim_var"
    inputBinding:
      position: 11
      prefix: '--method'
    label: 'Method of performing DE analysis [logreg|t-test|wilcoxon|t-test_overestim_var'
  
  - id: corr-method
    type: string
    default: "benjamini-hochberg"
    inputBinding:
      position: 12
      prefix: '--corr-method'
    label: 'P-value correction method [benjamini-hochberg|bonferroni'

  - id: rankby-abs
    type: boolean
    default: False
    inputBinding:
      position: 13
      prefix: '--rankby-abs'
    label: 'Rank genes by abs value of score'
  
  - id: filter-params
    type: string
    inputBinding:
      position: 14
      prefix: '--filter-params'
    label: 'Parameters for filtering DE results, can be:
            "min_in_group_fraction"(float)
            "max_out_group_fraction"(float)
            "min_fold_change"(float)'
  
  - id: logreg-params
    type: string
    inputBinding:
      position: 15
      prefix: '--logreg-params'
    label: 'Parameters passed to 'sklearn.linear_model.LogisticRegression'

  - id: save
    type: File
    inputBinding:
      position: 16
      prefix: '--save'
    label: 'Tab-separated table to store results of DE analysis'

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
