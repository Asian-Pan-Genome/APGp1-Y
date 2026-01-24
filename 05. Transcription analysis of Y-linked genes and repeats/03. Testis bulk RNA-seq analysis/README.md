The reference T2T-CHM13v2(Rhie et al., 2023; Sergey Nurk, 2022) is from NCBI (GCF_009914755.1).

Adult testis bulk RNA-seq datasets include SRR306857, SRR306858, SRR8575355-SRR8575362, SRR9849353, SRR9849354, and SRR23381330-SRR23381332.

### Gene expression analysis, for example:
```
STAR --runMode alignReads --runThreadN 8 --genomeDir ../../Reference/Human --readFilesIn ../Human_testis_1.SRR306857.fastq.gz --sjdbGTFfile ../../Reference/Human/chm13v2.0_RefSeq_Liftoff_v5.1.gff_convert.gtf --readFilesCommand gunzip -c --outFileNamePrefix Human_testis_1 --outSAMtype BAM Unsorted --winAnchorMultimapNmax 100 --outFilterMultimapNmax 100 --outFilterScoreMinOverLread 0.3 --outFilterMatchNminOverLread 0.3
samtools sort -@ 8 -o Human_testis_1.sort.bam Human_testis_1Aligned.out.bam
stringtie -e -B -p 8 -A Human_testis_1.gene_abund -o Human_testis_1.gtf -G ../../Reference/Human/chm13v2.0_RefSeq_Liftoff_v5.1.gff_convert.gtf Human_testis_1.sort.bam
```
