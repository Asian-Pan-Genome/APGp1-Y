# Y Chromosome Annotation Pipeline

This repository provides the annotation workflow, scripts, and key resources used for annotating **Y chromosomal subregions**, including satellites, amplicons, palindromes, genes, and repeats, as described in our [xxx](#).

## Overview

The pipeline integrates public and custom tools to annotate the following features on sample-specific `chrY` assemblies:

- Subregion classification via **coordinate liftover** from CHM13v2.0  
- Gene and pseudogene transfer via **Liftoff**  
- Repeat annotation with **RepeatMasker**  
- Satellite (DYZ1/DYZ2) detection using **k-mer**, **GC content**, and **HMMER**  
- Ampliconic region detection via **Winnowmap**-based alignment  
- Palindromic and IR structure identification via **self-alignment and Palindrover**  
- Manual curation of ambiguous regions

## Key Tools & Versions

- [nf-LO](https://github.com/evotools/nf-LO) v1.8.0  
- [Liftoff](https://github.com/agshumate/Liftoff) v1.6.3  
- [RepeatMasker](https://github.com/Dfam-consortium/RepeatMasker) v4.1.2 + Dfam 3.3  
- [Assembly_HSat2and3_v2.pl](https://github.com/altemose/chm13_hsat)  
- [HMMER](https://github.com/EddyRivasLab/hmmer) v3.4  
- [Winnowmap](https://github.com/marbl/Winnowmap) v2.03  
- [Palindrover](https://github.com/makovalab-psu/T2T_primate_XY/tree/main/palindrover_maf_align)  
- [Lastz](https://github.com/lastz/lastz) v1.04.00
- [R](https://www.r-project.org/) v4.1.3
- [chaintools](https://github.com/milkschen/chaintools) v0.1
- [paf2chain](https://github.com/AndreaGuarracino/paf2chain) v0.1.0
- [CrossMap](https://github.com/liguowang/CrossMap) v0.5.2

## 1. Annotation Commands

### 1.1 Subregion Annotation

**Generate chain files using nf-LO:**
```bash
  nextflow run nf-LO-1.8.0 \
    --source CHM13.Y.fasta \
    --target sample.chrY.fasta \
    --outdir sample_dir \
    -profile conda --aligner minimap2
  rm -r work
```
**process chain file with CHM13:**
```bash
python ~/Software/chaintools-0.1/src/split.py -c sample_dir/liftover.chain -o sample.CHM13.split.chain
python ~/Software/chaintools-0.1/src/to_paf.py -c sample.CHM13.split.chain  -t CHM13.Y.fasta -q sample.chrY.fasta -o sample.CHM13.split.paf
cat sample.CHM13.split.paf | rb break-paf --max-size 10000  | rb trim-paf -r | rb invert | rb trim-paf -r | rb invert > sample.CHM13.out.paf
~/Software/paf2chain/paf2chain -i sample.CHM13.out.paf > sample.CHM13.out.chain
rm sample.CHM13.chain sample.CHM13.split.chain sample.CHM13.split.paf
```
**Liftover CHM13 class annotation to sample:**
```bash
CrossMap.py bed sample.CHM13.out.chain CHM13.Y.class.bed > sample.chrY.sub_region.bed.CHM13_crossmap
grep -v Unmap sample.chrY.sub_region.bed.CHM13_crossmap > sample.chrY.sub_region.bed.CHM13_crossmap.filter
rm sample.chrY.sub_region.bed.CHM13_crossmap
perl crossmap_region_merge.pl sample.chrY.sub_region.bed.CHM13_crossmap.filter sample.chrY.sub_region.bed.CHM13_based.anno
#then manually trim the sample.chrY.sub_region.bed.CHM13_based.anno
```
### 1.2 Yq12 (DYZ1 / DYZ2) Annotation
**RepeatMasker:**
```bash
RepeatMasker -pa 8  -species human -e ncbi -dir output_dir -gff sample.chrY.fasta
```
**HMMER:**
```bash
nhmmer --cpu 16 --dna -o sample.DYZ1.nhmmer.txt --tblout sample.DYZ1.nhmmer.tab -E 1.60E-150 Y_DYZ1.cons.fa sample.chrY.fa
nhmmer --cpu 16 --dna -o sample.DYZ2.nhmmer.txt --tblout sample.DYZ2.nhmmer.tab -E 1.60E-150 Y_DYZ1.cons.fa sample.chrY.fa
bash runDYZ_by_hummerout.sh
```
**GC Content:**
```bash
samtools faidx sample.chrY.fasta
awk '{print $1"\t"$2}' sample.chrY.fasta.fai > sample.size
bedtools makewindows -g sample.size -w 100 | \
bedtools nuc -fi sample.chrY.fasta -bed stdin | grep -v "#" | cut -f1,2,3,5 > sample.100bp.GC
```
### 1.3 Palindrome Annotation
**Mapping**
```bash
mkdir -p kmer
meryl count k=15 output merylDB sample.chrY.fa
meryl print greater-than distinct=0.9998 merylDB > ./kmer/sample.repetitive_k15.txt
rm -rf merylDB/
winnowmap -W ./kmer/sample.repetitive_k15.txt --sv-off -ax map-pb sample.chrY.fa CHM13_GRCh38.IR.fasta | samtools view -h -F 2048 > sample.IR.sam
samtools view -bhS sample.IR.sam > sample.IR.bam
samtools sort sample.IR.bam > sample.IR.sorted.bam
samtools index sample.IR.sorted.bam
bedtools bamtobed -i sample.IR.sorted.bam > sample.IR.coordinates.txt
perl get_manually.pl sample.IR.coordinates.txt
perl delete.pl sample.IR.coordinates.txt
rm sample.IR.sam
mkdir sample
mv sample.* ./sample
```
**lastz alignment**
```bash

lastz sample.chrY.softmasked.fa sample.chrY.softmasked.fa --ungapped --filter=identity:80 --filter=nmatch:400 --hspthresh=36400 --format=general-:name1,start1,end1,name2,start2,end2,strand2,nmatch > sample_to_chrY.masked.anchors
lastz sample.chrY.softmasked.fa sample.chrY.softmasked.fa --segments=sample_to_chrY.masked.anchors --filter=identity:80 --filter=nmatch:1000 --allocate:traceback=1.99G --format=general:name1,zstart1,end1,name2,strand2,zstart2+,end2+,id%,cigarx --rdotplot+score=sample_to_chrY.masked.dots > sample_to_chrY.masked.dat
cat sample_to_chrY.masked.dat | python /share/home/zhanglab/user/liujing/nqy/software/palindrover/palindrover.py --identity=98% --length=2K | awk -F'\t' '{NF--; $1=$1}1' >  sample_Newpal.bed
```
### 1.4 Ampliconic Region Annotation
```bash

bedtools getfasta -bed hg38.amplicons.colors.adjust.bed -fi hg38.chrY.fasta -name -s -fullHeader > hg38.colors.fasta
echo BLUE | perl ~/Software/fishInWinter.pl -bf table -ff fasta --patternmode - hg38.colors.fasta > blue.hg38.default.fa
echo GRAY | perl ~/Software/fishInWinter.pl -bf table -ff fasta --patternmode - hg38.colors.fasta > gray.hg38.default.fa
echo GREEN | perl ~/Software/fishInWinter.pl -bf table -ff fasta --patternmode - hg38.colors.fasta > green.hg38.default.fa
echo RED | perl ~/Software/fishInWinter.pl -bf table -ff fasta --patternmode - hg38.colors.fasta > red.hg38.default.fa
echo TEAL | perl ~/Software/fishInWinter.pl -bf table -ff fasta --patternmode - hg38.colors.fasta > teal.hg38.default.fa
echo YELLOW | perl ~/Software/fishInWinter.pl -bf table -ff fasta --patternmode - hg38.colors.fasta > yellow.hg38.default.fa
ampliconName=( "blue" "gray" "green" "red" "teal" "yellow" )
for color in "${ampliconName[@]}"
do
  winnowmap -W ./kmer/sample.repetitive_k15.txt --sv-off -ax map-pb sample.chrY.fasta ${color}.hg38.default.fa | samtools view -h -F 2048 > sample.${color}.default.sam
	samtools view -bhS sample.${color}.default.sam > sample.${color}.default.bam
	samtools sort sample.${color}.default.bam > sample.${color}.default.sorted.bam
	samtools index sample.${color}.default.sorted.bam
	bedtools bamtobed -i sample.${color}.default.sorted.bam > sample.${color}.coordinates.txt
done
cat sample.*.coordinates.txt | sort -k1,1V -k2,2n > sample.amplicons.bed
#these are the coordinates to be used/potentially manually curated
```
### 1.5 PAR Boundary Refinement
```bash
lastz sample.chrX.fasta sample.chrY.fasta --filter=identity:80 --filter=nmatch:400 --hspthresh=36400 > anchors
lastz sample.chrX.fasta sample.chrY.fasta --segments=anchors --filter=nmatch:1000 --allocate:traceback=800M --format=general > align.dat
perl -lane 'if($F[4] eq "-"){($F[1], $F[2])=($F[2], $F[1])} print join("\t", @F)' align.dat > align.mod
samtools faidx sample.chrY.fasta
samtools faidx sample.chrX.fasta
Rscript dotplot.X_ref.r sample.chrX.fasta.fai sample.chrY.fasta.fai align.mod sample.subregion.bed.anno sample.XY.dotplot.pdf
```
