### Setp1. Construct ML tree
```
mafft --auto --thread 16 All_samples.TSPY_units.fa > All_samples.TSPY_units.fas
iqtree -s All_samples.TSPY_units.fas -T AUTO -bb 1000 -m TEST
```
### Setp2. Estimate Jaccard similarity
```
kmer-db build -k 21 -t 8 All_TSPY_unit.fa.list All_TSPY_unit.K21
kmer-db all2all -t 8 All_TSPY_unit.K21 All_TSPY_unit.K21.common_tab
kmer-db distance jaccard All_TSPY_unit.K21.common_tab All_TSPY_unit.K21.common_tab.jaccard
```
### Setp3. Mutation profiles among TSPY-FAM197Y units
#### Run nucmer to call SNPs and INDELs for each TSPY-FAM197Y unit, using HG01890.TSPY2_unit.fa as reference. For example:
```
nucmer -t 1 --mum -p KOR01-TSPY2 HG01890.TSPY2_unit.fa KOR01.TSPY2_unit.fa
delta-filter -i 95 -o 95 KOR01-TSPY2.delta -1 > KOR01-TSPY2.best.delta
show-snps -r -T KOR01-TSPY2.best.delta > KOR01-TSPY2.align.txt
~/Software/synPlot/bin/nucmer2SNP_InDel.pl KOR01-TSPY2.align.txt KOR01-TSPY2.align.snp.txt KOR01-TSPY2.align.indel.txt
```
#### Merge the variants of all units and convert merged_variants into VCF format
```
bash nucmer_to_vcf.workflow.sh
```
### Setp4. PCA analysis
```
vcftools --vcf All.TSPY_unit.all.merge.vcf --plink --out All.TSPY_unit.all.merge.vcf.pca
plink --noweb --file All.TSPY_unit.all.merge.vcf.pca --make-bed --out All.TSPY_unit.all.merge.vcf.pca_bfile
plink --threads 4 --bfile All.TSPY_unit.all.merge.vcf.pca_bfile --pca 3 --out All.TSPY_unit.all.merge.vcf.pca_bfile
```
### Setp5. PAML analysis
#### CDS align
```
mafft --auto --maxiterate 1000 --thread 4 Representive_samples.TSPY_CDS.fa > Representive_samples.TSPY_CDS.fas
clipkit Representive_samples.TSPY_CDS.fas -m gappy -o Representive_samples.TSPY_CDS.trimmed.fas
iqtree -s Representive_samples.TSPY_CDS.trimmed.fas -T 4 -bb 1000 -m TEST
```
#### Convert fas to phy on online http://phylogeny.lirmm.fr/
#### Run paml
```
codeml TSPY.free_ratio.ctl
```
#### Extract paml output
```
perl extract_free_ratio.pl TSPY.free-ratio.paml_out Representive_samples.TSPY.gene_convert.list TSPY.free-ratio.list
```

