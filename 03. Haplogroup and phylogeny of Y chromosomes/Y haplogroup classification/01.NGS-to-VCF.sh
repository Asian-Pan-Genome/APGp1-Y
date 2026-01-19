date
REF="/share/home/zhanglab/user/suomingyu/parent_analysis/CHM13v2m.fasta"
threads=20

NGSpath="/share/home/project/zhanglab/APG/NGS"
for sample in $(cat sample.list)
do
	echo $sample
	#-------------------------------------
	# Step1. Quality Control for Raw Reads
	#-------------------------------------
	echo "DATA QC and FILTERING..."
	ls $NGSpath/$sample/*_1.clean.fq.gz|while read a
	do
		pre=`echo $a|sed 's/_1.fq.gz//g'`
		echo $pre
		fastp -i $pre\_1.fq.gz -o $pre\_1.clean.fq.gz -I $pre\_2.fq.gz -O $pre\_2.clean.fq.gz -j $pre.json -h $pre.html -u 30 -q 20 -w $threads
	done
	echo "QC Finished!"

	#-------------------------------------
	# Step2. Downsample to 33X
	#-------------------------------------
	echo "downsaple to 33X"
	zcat $NGSpath/$sample/*_1.clean.fq.gz | seqkit head -n 500000000 -j $threads | gzip > $sample\_33X_R1.fq.gz
	zcat $NGSpath/$sample/*_2.clean.fq.gz | seqkit head -n 500000000 -j $threads | gzip > $sample\_33X_R2.fq.gz

	#-------------------------------------
	# Step3. Reads Mapping
	#-------------------------------------
	echo "33XDS mapping to CHM13"
	bwa mem $REF $sample\_33X_R1.fq.gz $sample\_33X_R2.fq.gz -t $threads -R '\@RG\\tID:${sample}\\tSM:${sample}\\tLB:library1\\tPL:BGI' > $sample\.sam
	samtools view -@ $threads -bS $sample\.sam > $sample\.bam
	samtools sort -@ $threads $sample\.bam -o $sample\.sorted.bam
	samtools index -@ $threads $sample\.sorted.bam
	samtools flagstat -@ $threads $sample\.sorted.bam > $sample\.flagstat
	echo "Mapping and sorting Finished!"

	#-------------------------------------
	# Step4. BAM Filter
	#-------------------------------------
	samtools view -@ 20 -bh -q 30 -F 2048 -F 256 $sample.sorted.bam -o $sample.filt.bam
	sambamba markdup  -r -p -t 20  --tmpdir=./ $sample.filt.bam $sample.filt.rmdup.bam
	samtools sort -@ 20 $sample.filt.rmdup.bam -o $sample.filt.rmdup.sort.bam
	samtools index -@ 20 $sample.filt.rmdup.sort.bam

	#-------------------------------------
	# Step4. gVCF Calling
	#-------------------------------------
	gatk HaplotypeCaller -R $REF -I $sample.filt.rmdup.sort.bam -O $sample.g.vcf -L chrY -ERC GVCF
done

#-------------------------------------
# Step5. Combine gVCF & VCF Filter
#-------------------------------------
gatk CombineGVCFs -R $REF \
$(for i in `ls *.g.vcf`;do echo "--variant ${i} ";done) \
-O cohort.g.vcf.gz

gatk GenotypeGVCFs -R $REF \
--variant cohort.g.vcf.gz \
-O merge.vcf

gatk SelectVariants \
	-select-type SNP  \
	-V merge.vcf \
	-O merge.snp.vcf

gatk VariantFiltration \
	-V merge.snp.vcf \
	--filter-expression "QD < 2.0 || MQ < 30.0 || FS > 60.0 || SOR > 3.0 || vc.hasAttribute('MQRankSum') < -12.5 || vc.hasAttribute('ReadPosRankSum') < -8.0 " \
	--filter-name "Filter" \
	-O merge.snp.filt.vcf

echo "Finish All!"
date
