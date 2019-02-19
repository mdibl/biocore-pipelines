class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
id: jr18_fastqc
baseCommand:
  - fastqc
inputs: []
outputs: []
label: jr18_fastqc
arguments:
  - position: 2
    prefix: '-t'
    valueFrom: $(runtime.tmpdir)
  - position: 4
    prefix: '-o'
    valueFrom: $(runtime.outdir)
