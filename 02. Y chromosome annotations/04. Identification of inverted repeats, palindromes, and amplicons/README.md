
## Palindrome Annotation
**Mapping(IR for example)**
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
cat sample_to_chrY.masked.dat | python ~/software/palindrover/palindrover.py --identity=98% --length=2K | awk -F'\t' '{NF--; $1=$1}1' >  sample_Newpal.bed
```
## Ampliconic Region Annotation
```bash
ampliconName=( "blue" "gray" "green" "red" "teal" "yellow" )
for color in "${ampliconName[@]}"
do
  winnowmap -W ./kmer/sample.repetitive_k15.txt --sv-off -ax map-pb sample.chrY.fasta ref/${color}.hg38.default.fa | samtools view -h -F 2048 > sample.${color}.default.sam
	samtools view -bhS sample.${color}.default.sam > sample.${color}.default.bam
	samtools sort sample.${color}.default.bam > sample.${color}.default.sorted.bam
	samtools index sample.${color}.default.sorted.bam
	bedtools bamtobed -i sample.${color}.default.sorted.bam > sample.${color}.coordinates.txt
done
cat sample.*.coordinates.txt | sort -k1,1V -k2,2n > sample.amplicons.colors.txt
#these are the coordinates to be used/potentially manually curated
python manually_max.py sample.amplicons.colors.txt sample.amplicons.colors.txt.max
mkdir sample
mv sample.* ./sample
cd sample
mkdir self_align
cd self_align
awk 'BEGIN{OFS="\t"} $4=="AMPL"{last_line="chr"$1 FS $2 FS $3 FS $4} END{print last_line}' sample.chrY.sub_region.bed.CHM13_based.anno > sample.ampl7
sed 's/ /\t/g' sample.ampl7 > sample.ampl7.bed
ln -s sample.chrY.fa ./sample.chrY.fa
ln -s ../sample.amplicons.colors.txt.max ./
awk -F'\t' 'BEGIN{OFS="\t"} {split($4,a,"."); $4=a[2]; print}' sample.amplicons.colors.txt.max >sample.amplicons.colors.txt.max2
bash Elements_self_align.sh sample.chrY.fa sample.ampl7.bed sample.amplicons.colors.txt.max2
```
