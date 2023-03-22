# dnanexus_bcftools_stats v2.0.0
This code is used to run bcftools stats. This app deploys bcftools v1.15.1 (docker image id = [bcftools_v1.15.1:491fe3cdb343](https://github.com/moka-guys/seglh-toolbox/releases/tag/seglh-bcftools_v1.15.1-491fe3cdb343)).

One use case is to run in the MokaRD workflow where the VCF filtering stage is optional. If the VCF is filtered it is this VCF that the stats should be calculated for. 
As the filtering stage may not be run this app has a second VCF input, a "back up" VCF eg the unfiltered output of the variant caller on which the stats will be calculated if the filtered VCF is not present.
## inputs
Required input files for the swiss army knife app:
* preferred VCF - optional 
* backup VCF - required

VCFs can be gzipped or not

## how the app works
If the preferred VCF is given this is used, otherwise the "back up" VCF input is used.
The vcf filename is used to name the output, with .vcf and .gz extensions removed.
The output is output to the project in /QC to ensure it is picked up by multiqc.

## Change log
v1.0 - designed to run within the swiss army knife
v2.0 - stand alone applet