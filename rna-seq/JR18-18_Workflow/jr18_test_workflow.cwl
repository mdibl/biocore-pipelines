class: Workflow
cwlVersion: v1.0
id: jr18_test_workflow
label: jr18_test_workflow
$namespaces:
  sbg: 'https://www.sevenbridges.com/'
inputs:
  - id: fastqFile
    type: File
    'sbg:x': -463.7945861816406
    'sbg:y': -529.8001098632812
  - id: reads1
    type: File
    'sbg:x': 65.5982437133789
    'sbg:y': -542.87158203125
  - id: reads2
    type: File
    'sbg:x': 52.66036605834961
    'sbg:y': -290.1120300292969
  - id: fastqFile_1
    type: File
    'sbg:x': -459.4222106933594
    'sbg:y': -339.91632080078125
  - id: fastqFile_2
    type: File
    'sbg:x': 656.48388671875
    'sbg:y': -527.421875
  - id: fastqFile_3
    type: File
    'sbg:x': 639.2028198242188
    'sbg:y': -316.4529113769531
outputs:
  - id: reads2_trimmed_unpaired
    outputSource:
      - trimmomatic/reads2_trimmed_unpaired
    type: File?
    'sbg:x': 413.7340087890625
    'sbg:y': -631.3432006835938
  - id: reads2_trimmed_paired
    outputSource:
      - trimmomatic/reads2_trimmed_paired
    type: File?
    'sbg:x': 417.3904724121094
    'sbg:y': -507.64019775390625
  - id: reads1_trimmed_unpaired
    outputSource:
      - trimmomatic/reads1_trimmed_unpaired
    type: File?
    'sbg:x': 436.2655944824219
    'sbg:y': -381.140380859375
  - id: reads1_trimmed
    outputSource:
      - trimmomatic/reads1_trimmed
    type: File
    'sbg:x': 408.92169189453125
    'sbg:y': -267.5463562011719
  - id: output_log
    outputSource:
      - trimmomatic/output_log
    type: File
    'sbg:x': 366.35870361328125
    'sbg:y': -146.70298767089844
steps:
  - id: fastqc
    in:
      - id: fastqFile
        source:
          - fastqFile
          - fastqFile_1
    out:
      - id: report
      - id: zippedFile
    run: ../Documents/workflows/tools/fastqc.cwl
    'sbg:x': -216.08103942871094
    'sbg:y': -436.66497802734375
  - id: trimmomatic
    in:
      - id: reads1
        source:
          - reads1
          - reads2
    out:
      - id: output_log
      - id: reads1_trimmed
      - id: reads1_trimmed_unpaired
      - id: reads2_trimmed_paired
      - id: reads2_trimmed_unpaired
    run: ../Documents/workflows/tools/trimmomatic.cwl
    'sbg:x': 250.32211303710938
    'sbg:y': -362.44317626953125
  - id: fastqc_1
    in:
      - id: fastqFile
        source:
          - fastqFile_2
          - fastqFile_3
    out:
      - id: report
      - id: zippedFile
    run: ../Documents/workflows/tools/fastqc.cwl
    'sbg:x': 837.8743896484375
    'sbg:y': -385.46881103515625
requirements:
  - class: MultipleInputFeatureRequirement
