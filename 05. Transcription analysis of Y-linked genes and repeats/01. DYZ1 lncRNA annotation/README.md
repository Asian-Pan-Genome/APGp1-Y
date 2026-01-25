## DYZ1 lncRNA annotation
Iso-seq data were from adult testis (SRR12544672, SRR12544673 and SRR31360662), adult brain (SRR28012723 and SRR28012724), lymphocytes (ERR12944321 and ERR12944331), and human embryonic stem cells (hESC; SRR25855040). DYZ1 lncRNA annotation used adult testis SRR31360662 Isoseq data with workflow of IsoSeq V3 (https://isoseq.how/) and SQANTI3 (https://github.com/ConesaLab/SQANTI3/wiki).
## Prerequisites
- Minimap2 (v2.26)
- cDNA_Cupcake (v28.0.0)
- SQANTI3 (v3-5.1)
- Deeptools (v3.5.1)
## Workflow
1. Iso-Seq Collapse
```
minimap2 -t 8 -ax splice -uf --secondary=no -C5 Human.fa Human.SRR31360662_subreads.fastq > Human.Testis_Isoseq_1.align.sam
samtools view -@ 8 -b Human.Testis_Isoseq_1.align.sam > Human.Testis_Isoseq_1.align.bam
samtools sort -@ 8 Human.Testis_Isoseq_1.align.sam -o Human.Testis_Isoseq_1.align.sort.bam
collapse_isoforms_by_sam.py --input Human.SRR31360662_subreads.fastq --fq -b Human.Testis_Isoseq_1.align.sort.bam  --dun-merge-5-shorter -o testis_all
```
2. Classification
```
python sqanti3_qc.py testis_all.collapsed.gff chm13v2.0_RefSeq_Liftoff_v5.1.gff_convert.gtf Human.fa -o human_all -d human --report both --cpus 10 --isoAnnotLite
python sqanti3_filter.py rules -j filter.json --isoforms human_testis_corrected.fasta --gtf human_testis_corrected.gtf.cds.gff --faa human_testis_corrected.faa -o filter -d ./ human_testis_classification.txt
```
3. Coverage
```
samtools view -b Human.Testis_Isoseq_1.align.sort.bam Y -o Human.Testis_Isoseq_1.chrY.bam
bamCoverage -b Human.Testis_Isoseq_1.chrY.bam --normalizeUsing RPKM --effectiveGenomeSize 62450000 -o testis_isoseq_rpkm.bed -of bedgraph
```
