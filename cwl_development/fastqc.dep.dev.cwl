class: CommandLineTool
cwlVersion: v1.0
$namespaces:
    edam: 'http://edamontology.org/'
    s: 'http://schema.org/'

requirements:
  - class: InlineJavascriptRequirement

hints:
  DockerRequirement:
    dockerPull: biocontainers/fastqc

baseCommand: [fastqc]
inputs:
  - id: seqfile
    type: File[]
    inputBinding:
      position: 1
    label: 'A set of sequence files'
    doc: > 
      "A set of sequence files"

  - id: casava
    type: boolean?
    default: false
    inputBinding:
      prefix: --casava
    label: 'Files originate from raw casava output'
    doc: >
      "Files come from raw casava output. Files in the same sample group 
      (differing only by the group number) will be analysed as a set rather than individually. 
      Sequences with the filter flag set in the header will be excluded from the analysis. 
      Files must have the same names given to them by casava 
      (including being gzipped and ending with .gz) otherwise they won't be grouped together correctly."
  - id: nano
    type: boolean?
    default: false
    inputBinding:
      prefix: --nano
    label: 'Files come from naopore sequences and are in fast5 format'
    doc: >
      "Files come from naopore sequences and are in fast5 format. 
      In this mode you can pass in directories to process and the program will take in all fast5 files 
      within those directories and produce a single output file from the sequences found in all files."
  - id: nofilter
    type: boolean?
    default: false
    inputBinding:
      prefix: --nofilter
    label: 'If running with --casava, don't remove read flagged by casava as poor'
    doc: >
      "If running with --casava then don't remove read flagged by casava 
      as poor quality when performing the QC analysis."
  - id: extract
    type: boolean?
    default: false
    inputBinding:
      prefix: --extract
    label: 'The zipped output file will be uncompressed'
    doc: >
      "If set then the zipped output file will be uncompressed in the same directory after it has been created. 
      By default this option will be set if fastqc is run in non-interactive mode."
  - id: java
    type: File?
    inputBinding:
      prefix: --java
    label: 'The full path to the java binary you want to use to launch fastqc'
    doc: >
      "Provides the full path to the java binary you want to use to launch fastqc. 
      If not supplied then java is assumed to be in your path."
  - id: noextract
    type: boolean?
    default: true
    inputBinding:
      prefix: --noextract
    label: 'Do not uncompress the output file'
    doc: >
      "Leaves output file in compressed form. Set this option if you don't want to uncompress output"
  - id: nogroup
    type: boolean?
    default: true
    inputBinding:
      prefix: --nogroup
    label: 'Disable grouping of bases for reads >50bp'
    doc: >
      "Disable grouping of bases for reads >50bp. All reports will show data for every base in the read. 
      WARNING: Using this option will cause fastqc to crash and burn if you use it on really long reads, 
      and your plots may end up a ridiculous size. You have been warned!"
  - id: min_length
    type: int?
    default: true
    inputBinding:
      prefix: --min_length
    label: 'Sets artificial lower limit on the length of sequence to be shown in the report'
    doc: >
      "Sets an artificial lower limit on the length of the sequence to be shown in the report. 
      As long as you set this to a value greater or equal to your longest read length then this 
      will be the sequence length used to create your read groups. This can be useful for making 
      directly comaparable statistics from datasets with somewhat variable read lengths."
  - id: input_format
    type: string?
    inputBinding:
      prefix: --format
    label: 'Bypasses normal sequence file format detection, forces program to use specified format'
    doc: >
      "Bypasses the normal sequence file format detection and forces the program to use the specified format. 
      Valid formats are bam,sam,bam_mapped,sam_mapped and fastq"
  - id: nthreads
    type: int
    inputBinding:
      prefix: --threads
    label: 'The number of files which can be processed simultaneously'
    doc: >
      "Specifies the number of files which can be processed simultaneously. 
      Each thread will be allocated 250MB of memory so you shouldn't run more threads 
      than your available memory will cope with, and not more than 6 threads on a 32 bit machine"
  - id: contaminants
    type: File?
    inputBinding:
      prefix: --contaminants
    label: 'A non-default file which contains the list of contaminants to screen overrepresented sequencs against'
    doc: >
      "Specifies a non-default file which contains the list of contaminants to screen overrepresented 
      sequences against. The file must contain sets of named contaminants in the form name[tab]sequence. 
      Lines prefixed with a hash will be ignored."
  - id: adapters
    type: File?
    inputBinding:
      prefix: --adapters
    label: 'A non-default file which contains the list of adapter sequences'
    doc: >
      "Specifies a non-default file which contains the list of adapter sequences 
      which will be explicity searched against the library. 
      The file must contain sets of named adapters in the form name[tab]sequence. 
      Lines prefixed with a hash will be ignored."
  - id: limits
    type: File?
    inputBinding:
      prefix: --limits
    label: 'a non-default file, contains a set of criteria which will be used to determine the warn/error limits for the various modules'
    doc: >
      "Specifies a non-default file which contains a set of criteria which will be used to determine the warn/error limits for the various modules. 
      This file can also be used to selectively remove some modules from the output all together. 
      The format needs to mirror the default limits.txt file found in the Configuration folder."
  - id: kmers
    type: int?
    inputBinding:
      prefix: --kmers
    label: 'The length of Kmer to look for in the Kmer content module'
    doc: >
      "Specifies the length of Kmer to look for in the Kmer content module. 
      Specified Kmer length must be between 2 and 10. 
      Default length is 7 if not specified."


stdout: $(inputs.output_prefix + "_fastqc_con.txt")
stderr: $(inputs.output_prefix + "_fastqc_err.txt")
