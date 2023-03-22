#!/bin/bash

# The following line causes bash to exit at any point if there is any error
# and to output each line as it is executed -- useful for debugging
set -e -x -o pipefail

dx-download-all-inputs --parallel
# make output folder
mkdir -p ~/out/bcftools_stats_output/QC
# download BCFtools docker -  currently image seglh-bcftools_v1.15.1-491fe3cdb343
Docker_file_ID=project-ByfFPz00jy1fk6PjpZ95F27J:file-GQB5qJ80jy1yF0209p0qv0ZJ
dx download ${Docker_file_ID}
Docker_image_file=$(dx describe ${Docker_file_ID} --name)
Docker_image_name=$(tar xfO "${Docker_image_file}" manifest.json | sed -E 's/.*"RepoTags":\["?([^"]*)"?.*/\1/')
#Load docker image
docker load < /home/dnanexus/"${Docker_image_file}"
echo "Using BCFtools docker image ${Docker_image_file}"

# preferred VCF is optional, check if this is present and build path to input VCF and vcf file name as required
if [[ -z $preferred_VCF_path ]]
then 
	# could be gzipped or not and be bedfiltered or not - remove any extensions (.vcf.gz or .vcf)
	test_vcf_name=$(echo $backup_VCF_name |  sed 's/.vcf//' | sed 's/.gz//')
	test_vcf_path=$backup_VCF_path
else
	# could be gzipped or not and be bedfiltered or not - remove any extensions (.vcf.gz or .vcf)
	test_vcf_name=$(echo $preferred_VCF_name | sed 's/.vcf//' | sed 's/.gz//')
	test_vcf_path=$preferred_VCF_path
fi

docker run -v /home/dnanexus:/home/dnanexus --rm ${Docker_image_name} stats $test_vcf_path > ~/out/bcftools_stats_output/QC/$test_vcf_name.stats

# Send output back to DNAnexus project
dx-upload-all-outputs --parallel
