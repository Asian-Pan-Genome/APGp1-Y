#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <Ref> <Qry>"
  exit 1
fi

ref_name="$1"
qry_name="$2"
dir=/share/home/zhanglab/user/liujing/LiuJing/03_pangenome/SV/Mummer_Syri/01_Assembly

#conda activate nf-LO
##02_rerun_syri
echo -e "${ref_name}.fa\t${ref_name}\tlw:2" > ${qry_name}.genomes.txt
echo -e "${qry_name}.ragtag.fa\t${qry_name}\tlw:2" >> ${qry_name}.genomes.txt
nucmer --maxmatch -c 500 -b 500 -l 1000 -t 8 ${ref_name}.fa ${qry_name}.ragtag.fa -p ${qry_name}.ragtag
delta-filter -m -i 95 -l 1000 ${qry_name}.ragtag.delta > ${qry_name}.ragtag.i95_l1000.delta
show-coords -THrd ${qry_name}.ragtag.i95_l1000.delta > ${qry_name}.ragtag.i95_l1000.coords
#rm ${qry_name}.delta
syri -c ${qry_name}.ragtag.i95_l1000.coords -d ${qry_name}.ragtag.i95_l1000.delta -r ${ref_name}.fa -q ${qry_name}.ragtag.fa --prefix ${qry_name}.ragtag
plotsr --sr ${qry_name}.ragtagsyri.out --genomes ${qry_name}.genomes.txt -H 3 -W 5 -o ${qry_name}.ragtagsyri.pdf

