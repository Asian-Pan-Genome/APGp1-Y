## Step1. Extract amplicon sequences from AMPL7_hap.amplicons.renamed.bed

`perl extract_fasta_and_nucmer_shell.pl AMPL7.175_hap.sam_list amplicon.rename.list AMPL7_hap.amplicons.renamed.bed Amplicons.length_threshold 01.extract_amp_fasta.sh`

The output1 '01.extract_amp_fasta.sh' includes multiple records.
For example:
```
bedtools getfasta -fi /share/home/zhanglab/user/liujing/LiuJing/00_chrY/Freezed/Freeze_v0.9/C001-CHA-E01.chrY.freeze.fa -bed Blue/C001-CHA-E01.b1.bed -fo Blue/C001-CHA-E01.b1.fa -nameOnly -s
```
The output2 includes 02.numcer_Blue.sh, 02.numcer_Gray.sh, 02.numcer_Green.sh and 02.numcer_Red.sh for running the nucmer.
For example: 
```
nucmer -t 8 --mum -p Blue/NA20509.b4 Blue/HG03248.b2.fa Blue/NA20509.b4.fa && delta-filter -i 95 -o 95 Blue/NA20509.b4.delta -1 > Blue/NA20509.b4.best.delta && show-snps -r -T Blue/NA20509.b4.best.delta > Blue/NA20509.b4.align.txt && ~/Software/synPlot/bin/nucmer2SNP_InDel.pl Blue/NA20509.b4.align.txt Blue/NA20509.b4.align.snp.txt Blue/NA20509.b4.align.indel.txt
```
Sbatch the 02.numcer_*.sh to run nucmer to call variants for each amplicon subgroup of each individual, with references: HG03248.r1, HG03248.b2, HG03248.g1 and HG03248.gy1, respectively. The fasta files for the references were provided in the directory.
## Step2. Extract SNP & INDEL for each amplicon family
```
perl extract_variant_allele.pl Gray && perl extract_variant_allele.pl Green && perl extract_variant_allele.pl Red && perl extract_variant_allele.pl Blue
```
#### Variant allele filtering (MAF>=0.05)
#Total number of Blue amplicons: 591

#Total number of Green amplicons: 417

#Total number of Gray amplicons: 287

#Total number of Red amplicons: 572
```
perl variant_allele_filter.pl Blue.SNP.allele.list 591 Blue.SNP.allele.filter.list
perl variant_allele_filter.pl Blue.INDEL.allele.list 591 Blue.INDEL.allele.filter.list
perl del_ins_separate.pl Blue.INDEL.allele.filter.list Blue.INDEL.ins_allele.list Blue.INDEL.del_allele.list
```
#### Convert site variants to vcf
```
perl nucmersite_to_vcf.pl Blue.fasta.list Blue.SNP.allele.filter.list Blue.SNP.vcf
perl nucmersite_to_vcf.pl Blue.fasta.list Blue.INDEL.del_allele.list Blue.INDEL_DEL.vcf
perl nucmersite_to_vcf.pl Blue.fasta.list Blue.INDEL.ins_allele.list Blue.INDEL_INS.vcf
```
#### Merge vcf into biallelic based on AF/AC and PCA
```
perl Variant_merge.pl Blue.INDEL_DEL.vcf Blue.INDEL_INS.vcf Blue.SNP.vcf Blue.all.merge.vcf
python pca_from_vcf.py --vcf Blue.all.merge.vcf --out Blue --pca_n 10
```
## Step3. Diagnostic sites specific to each amplicon subgroup were defined as positions at which the ‘alternative allele’ frequency differed from the reference by more than 0.90 in a given subgroup (e.g., r1 or g3), or in a pair of subgroups (e.g., r3/r4 or b1/b2), relative to all other subgroups.
#### Generate primary Diagnostic sites
```
perl Red_div_site_cal.pl Red.all.merge.vcf 0.90 Red.subtypes.div_0.90.sites
perl Blue_div_site_cal.pl Blue.all.merge.vcf 0.90 Blue.subtypes.div_0.90.sites
perl Gray_div_site_cal.pl Gray.all.merge.vcf 0.90 Gray.subtypes.div_0.90.sites
perl Green_div_site_cal.pl Green.all.merge.vcf 0.90 Green.subtypes.div_0.90.sites
```
#### Manually filtering the diagnostic sites using generated 31-mer frequency (*.amplicon_type.kmer.tsv) regarding 'Ref' and 'Alt' alleles of 175 Y assemblies with known haplotype of micro-deletion or duplication or gene conversions in AMPL7. The selected diagnostic sites are included in *.selected_sites.list. Though not every haplotype exhibits expected 31-mer counts regarding two alleles, the combination of all diagnostic sites is valid to identify different types of haplotypes.
```
# Extract all amplicon fasta
perl extract_fasta.pl /share/home/zhanglab/user/liujing/LiuJing/03_pangenome/SV/AMP/Reconstruction/New_order/Re_name/Blue Blue.amplicon_type.list Blue.amplicon_type.fasta
# Mafft alignment
sbatch Blue.align.sh
# Generate 31-mer sequences of 'Ref' and 'Alt' alleles for each diagnostic site
python step1_design_markers.py --msa Blue.amplicon_type.aligned.fasta --class_file Blue.amplicon_type.list --site_file Blue.subtypes.div_0.90.sites --ref_id HG03248-b2 --k_sizes 31 --output Blue.amplicon_type.kmer.tsv
```
#### Generate the counts of 31-mer ('Ref' and 'Alt') and normalize based on the read depth from control region (XDR3).
```
python step2_quantify_CN.py --kmer_db Blue.selected_sites.amplicon_type.kmer.tsv --bam /share/home/project/zhanglab/APG/NGS/C001-CHA-E01-01/C001-CHA-E01-01.sorted.bam --control_region chrY:12656463-14891106 --target_region chrY:22270252-27124000 --out_prefix Blue_C001-CHA-E01
```
#### Merge the normalized depth of all diagnostic sites for all the NGS dataset, and run PCA
```
perl KmerCount_merge.pl Amplicons.160_Sample.KmerCount.out
python step3.pca_only_from_kmer_table.py --kmer_table Amplicons.160_Sample.KmerCount.out --n_pca 5 --out_prefix 160_Sample.PCA
```
## Step4. Extract 31-mer frequency for the three micro-deletion types reported in the manuscript:
```
perl extract_kmer_frq.pl Three_types_DEL.list Amp.selected_sites.merged.r3.list Amplicons.160_Sample.KmerCount.out Amplicons.Three_DELs.KmerFrq.r3.out
# Cal_normalized_depth
perl cal_normalized_depth.pl Amplicons.Three_DELs.KmerFrq.r3.out Amplicons.Three_DELs.Kmer.Normalized_depth.r3.out
perl Control_normalization.pl Amplicons.Three_DELs.Kmer.Normalized_depth.r3.out Amplicons.Three_DELs.Kmer.Control_Normalized_depth.out
```
