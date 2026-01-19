#extract allele for the nucmer_out_dir
perl extract_allele.pl All_genes.SNP.allele.list All_genes.INDEL.allele.list
#allele count
perl allele_count.pl All_genes.SNP.allele.list All_genes.INDEL.allele.list All_genes.SNP_INDEL.allele_count All_genes.SNP_INDEL.allele_overlap.out
#allele filter (AC>1)
perl allele_filter.pl All_genes.SNP.allele.list All_genes.SNP.allele.filter.list
perl allele_filter.pl All_genes.INDEL.allele.list All_genes.INDEL.allele.filter.list
perl del_ins_separate.pl All_genes.INDEL.allele.filter.list All_genes.INDEL.ins_allele.list All_genes.INDEL.del_allele.list
#convert site_variant to vcf
perl nucmersite_to_vcf.pl All.TSPY_unit.list All_genes.SNP.allele.filter.list All.TSPY_unit.SNP.merge.vcf
perl nucmersite_to_vcf.pl All.TSPY_unit.list All_genes.INDEL.del_allele.list All.TSPY_unit.INDEL_DEL.merge.vcf
perl nucmersite_to_vcf.pl All.TSPY_unit.list All_genes.INDEL.ins_allele.list All.TSPY_unit.INDEL_INS.merge.vcf
##merge vcf into biallelic based on AF/AC
perl Variant_merge.pl All.TSPY_unit.INDEL_DEL.merge.vcf All.TSPY_unit.INDEL_INS.merge.vcf All.TSPY_unit.SNP.merge.vcf All.TSPY_unit.all.merge.vcf
