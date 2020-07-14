class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  edam: 'http://edamontology.org/'
  s: 'http://schema.org/'

baseCommand: [ hmmscan ]
inputs:
	-	id: cpu_count
		type: int
		default: 12
		inputBinding:
			position: 1
			prefix: '--cpu'
		label: 'number of cpu cores available'
	-	id:	domtblout
		type: File
		inputBinding:
			position: 2
			prefix: '--domtblout'
		label: 'produces domain hits table'

  $schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/version/latest/schema.rdf'
s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "MDI Biological Laboratory, 2019"
s:author: "Nathaniel Maki"