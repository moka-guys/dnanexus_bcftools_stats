# dnanexus_bcftools_stats v1.0.0
This code is used to run bcftools stats using the swiss army knife app (v4.7.1). This app deploys bcftools v1.15.1.

## inputs
Required input files for the swiss army knife app:
* vcf (can be gzipped or not)
* A bash script (bcftools_stats*.sh) from this repo that describes the processing required.

The app's "command line" input is used to execute the above bash script. This command is recorded in command_line_input.sh

## how the app works
bcftools_stats*.sh simply loops through any inputs with vcf in the filename and runs bcftools stats.
The vcf filename is split on '.' and everything before the first '.' is used to name the output.
The output is output to the project in /QC to ensure it is picked up by multiqc.