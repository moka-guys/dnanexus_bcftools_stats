#make QC folder to organise project
mkdir -p QC
for vcf in *vcf*
do
	#capture filename
	vcf_filename=$(echo $vcf | cut -d . -f1)
	# run bcftools stats outputting to QC folder
	bcftools stats $vcf > QC/$vcf_filename.stats
done