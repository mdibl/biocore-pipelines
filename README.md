# This repo is a root directory for biocore pipeline analysis and development

## Overview:

Central location in which the MDIBL Biocore maintains, optimizes, and develops tools, configuration files, and pipelines for bioinformatics analysis.

## Details:

Included in this repository are functional pipelines and components for RNA-seq analysis, CHIP-seq analysis and scRNA-seq analysis.
Pipelines are written using the Common Workflow Language (CWL), and augmented by either JSON or YAML configuration files.
The base tools used in each workflow, or sub-pipeline, are written in a variety of languages and encompassed by a CWL wrapper script.
These tools range from fully compiled programs such as Fastqc, to simple Shell scripts.
