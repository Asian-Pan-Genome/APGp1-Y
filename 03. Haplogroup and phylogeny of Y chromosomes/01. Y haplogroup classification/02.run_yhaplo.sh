###Convert APG_Y.merge.snp.filt.vcf to hg19_based
java -jar ~/software/picard.jar CreateSequenceDictionary R=hg19.fa
java -jar ~/software/picard.jar LiftoverVcf I=APG_Y.merge.snp.filt.vcf O=APG_Y.CHM13_convert_to_hg19.vcf CHAIN=chm13v2-hg19.chain REJECT=APG_Y.chm13v2-hg19.rejected_variants.vcf R=hg19.fa
###hg19 chrY callable regions is from Poznik, et al., 2013, Science.
perl extract_vcf.pl S1b.chrY.callable.hg19.bed APG_Y.CHM13_convert_to_hg19.vcf CHM13_convert_to_hg19.callable.vcf
##run yhaplo
bgzip -c CHM13_convert_to_hg19.callable.vcf > CHM13_convert_to_hg19.callable.vcf.gz
tabix -fp vcf CHM13_convert_to_hg19.callable.vcf.gz
yhaplo --input CHM13_convert_to_hg19.callable.vcf.gz -aao -o APG_Y