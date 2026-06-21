### Step1. Extract amplicon sequences from AMPL7_hap.amplicons.renamed.r4.bed

`perl extract_fasta_and_nucmer_shell.pl AMPL7.175_hap.sam_list amplicon.rename.list AMPL7_hap.amplicons.renamed.r4.bed Amplicons.length_threshold 01.extract_amp_fasta.sh`

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
### Step2. Extract SNP & INDEL for each amplicon family
```
perl extract_variant_allele.pl Gray && perl extract_variant_allele.pl Green && perl extract_variant_allele.pl Red && perl extract_variant_allele.pl Blue
```
#### Extract common variant (MAF >= 0.1)
```
perl Maf_filter.pl Blue.all.merge.vcf 0.1 Blue.all.merge.MAF0.1.vcf
```
### Step3. Make marker chain from amplicon vcf for each sample
```
perl make_variant_marker_chain.pl Amplicon.rename.list short_blue.list AMPL7_hap.amplicons.renamed.r4.bed
```
### Step4. Generate marker-based matching dotpot for pairwise samples
For example:
```
python markerWindowDotplot.add_similarity.py C037-CHA-S17.amplicons.variant_markers.list C039-CHA-S19.amplicons.variant_markers.list C037_C039.20Kb_100bp.pdf --out_table C039_C039.20Kb_100bp.win_similarity.out --window_bp 20000 --step_bp 10000 --cluster_bp 100
```
