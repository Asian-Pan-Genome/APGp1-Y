## DYZ2 piRNA expression profiling
Small piRNA datasets include adult testis (SRR2156557, SRR835324 and SRR835325), fetal testis (SRR2156556), and human bronchial epithelial (HBE) cell (SRR1287034 and SRR1287035).
## Prerequisites
- Bowtie
- Deeptools
## Workflow
1. Remove other small RNA reads
```
awk '$3=="transcript"' chm13v2.0_RefSeq_Liftoff_v5.1.gff_convert.gtf | grep -E -w 'snoRNA|snRNA|Y_RNA|telomerase_RNA|vault_RNA|RNase_MRP_RNA|RNase_P_RNA|scRNA|tRNA|miRNA' |grep -v 'mRNA' > sRNA.gtf
convert2bed -i gtf -o bed <sRNA.gtf > sRNA.bed
bedtools getfasta -fi Human.fa -bed sRNA.bed -fo sRNA.fa
bowtie-build sRNA.fa other_sRNA
bowtie -a --best --strata -v 1 -x other_sRNA ${sample}_clean.fastq -S test1.sam --un ${sample}_un.fastq

seqkit grep -r -p ^hsa hairpin.fa > hairpin_human.fa
seqkit grep -r -p ^hsa mature.fa > mature_human.fa
cat miRNA.fa mature_human.fa hairpin_human.fa > miRNA_human.fa
bowtie-build miRNA_human.fa human_miRNA
bowtie -a --best --strata -v 1 -m 10 -x human_miRNA ${sample}_un.fastq -S miRNA1.sam --un ${sample}_piRNA.fastq
```
2. piRNA map
```
bowtie-build Human.fa human
bowtie -a --best --strata -v 1 -x human  ${sample}_piRNA.fastq_piRNA.fastq -S  ${sample}.sam
ls *.sam | while read i; do samtools view -@ 4 -Sb -o $(basename $i .sam).bam $i; done
ls *.bam |while read i; do samtools sort -O BAM -@ 5 -o $(basename $i .bam).sort.bam $i;done
ls *.sort.bam | while read i; do samtools index $i; done
```
3. Coverage
```
ls *.sort.bam | while read i; do samtools view -H $i > $(basename $i .sort.bam).header; done
samtools view -@ 4 ${sample}.sort.bam |awk '$3=="Y"' | awk '{if ($1 ~ /^@/ || ($6 ~ /^[0-9]+M$/ && $6+0 >= 26 && $6+0 <= 31)) print $0}' |cat piRNA1_and_miRNA.header - | samtools view -b -o ${sample}_chrY.filt.bam -
ls *_chrY.filt.bam | while read i; do echo nohup bamCoverage -b $i --normalizeUsing CPM --effectiveGenomeSize 32400000 -o $(basename $i _chrY.filt.bam).CPM.bigwig \&; done > run.bigwig.sh
sh run.bigwig.sh
```
