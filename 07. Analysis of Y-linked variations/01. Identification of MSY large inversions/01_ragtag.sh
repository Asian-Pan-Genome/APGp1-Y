#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <Ref> <Qry>"
  exit 1
fi

ref_name="$1"
qry_name="$2"
dir=/share/home/zhanglab/user/liujing/LiuJing/03_pangenome/SV/Mummer_Syri/01_Assembly

#conda activate ragtag
##01_ragtag
ln -s ${dir}/${ref_name}.fa
ln -s ${dir}/${qry_name}.fa

ragtag.py scaffold ${ref_name}.fa ${qry_name}.fa -t 8 -o ${qry_name}.ragtag
sed -i 's/_RagTag//g' ${qry_name}.ragtag/ragtag.scaffold.fasta
samtools faidx ${qry_name}.ragtag/ragtag.scaffold.fasta chrY > ${qry_name}.ragtag.fa
rm -r ${qry_name}.ragtag

