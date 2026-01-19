#!/bin/bash


if [ $# -ne 3 ]; then
  echo "Usage: $0 <fasta> <ampl_bed> <color_bed>"
  echo "Make sure chrY.fasta and ampl_bed are in current dir!"
  echo "need activate nf-LO"
  echo "ampl_bed should be like:
		C048_Y	22705857	27628254"
  echo "Make bed file of P1_P3 color elements:
		e.g.:
		chr	start	end	class
		C048_Y	23243772	23411483	BLUE
		C048_Y	23411480	23527173	TEAL"
  exit 1
fi

fasta="$1"
ampl_bed="$2"
color_bed="$3"
sample=$(echo "$fasta" | awk -F'.' '{print $1}')
ampl=$(echo "$ampl_bed" | awk -F'.' '{print $2}')
#echo "$sample"
#echo "$ampl"

module load bedtools/2.29.1
module load samtools/1.16.1
bedtools getfasta -fi ${fasta} -bed ${ampl_bed} > ${sample}.${ampl}.fasta
lastz ${sample}.${ampl}.fasta ${sample}.${ampl}.fasta --ungapped --filter=identity:80 --filter=nmatch:400 --hspthresh=36400 --format=general-:name1,start1,end1,name2,start2,end2,strand2,nmatch > ${sample}.${ampl}.self_align.anchors
lastz ${sample}.${ampl}.fasta ${sample}.${ampl}.fasta --segments=${sample}.${ampl}.self_align.anchors --filter=identity:80 --filter=nmatch:1000 --allocate:traceback=800M --format=general:name1,zstart1,end1,name2,strand2,zstart2+,end2+,nmatch,length1,id%,blastid% --rdotplot+score=${sample}.${ampl}.self_align.dots > ${sample}.${ampl}.self_align.dat
perl -lane 'if($F[4] eq "-"){($F[1], $F[2]) = ($F[2], $F[1])} $out=join("\t", @F); print $out' ${sample}.${ampl}.self_align.dat > ${sample}.${ampl}.self_align.dat.mod
samtools faidx ${sample}.${ampl}.fasta
perl ~/nqy/AMPL/self_align/cord_trans.pl ${sample}.${ampl}.bed ${color_bed}
Rscript /slurm/home/zju/zhanglab/liujing/nqy/ref/dotplot.colors.r ${sample}.${ampl}.fasta.fai ${sample}.${ampl}.fasta.fai ${sample}.${ampl}.self_align.dat.mod ${color_bed}.cord_trans ${sample}.${ampl}.self_align.dotplot.color.pdf
