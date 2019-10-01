 class: CommandLineTool
 cwlVersion: v1.0
 doc: Unzips a zipped fastqc report and returns the fastqc_data.txt file. Unzips the file to pipe and uses redirection
 hints:
    DockerRequirement:
      dockerPull: dukegcb/fastqc # Just so that unzip is installed
 inputs:
    pipe:
      type: boolean
      default: true
      inputBinding:
        prefix: -p
        position: 1
    input_basename:
      type: string
    input_qc_report_file:
      type: File
      inputBinding:
        position: 2
    extract_pattern:
      type: string
      default: '*/fastqc_data.txt'
      inputBinding:
        position: 3
 outputs:
    output_fastqc_data_file:
      type: File
      outputBinding:
        glob: $(inputs.input_basename + '.fastqc_data.txt')
<<<<<<< HEAD
 baseCommand: unzip
 stdout: $(inputs.input_basename + '.fastqc_data.txt')
=======
    console_log:
      type: stdout
    error_log: 
      type: stderr
 baseCommand: unzip
 stdout: $(inputs.input_qc_report_file.basename).extract_fastqc_data_console_log.txt
 stderr: $(inputs.input_qc_report_file.basename).extract_fastqc_data_error_log.txt
>>>>>>> dev
