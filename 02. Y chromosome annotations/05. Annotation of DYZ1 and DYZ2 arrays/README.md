## Yq12 (DYZ1 / DYZ2) Annotation
**Alu and HSATI element in DYZ2 Regions were classified based on RepeatMasker output:**
```bash
RepeatMasker -pa 8  -species human -e ncbi -dir output_dir -gff sample.chrY.fasta
```
**Using HMMER to define boundaries for individual repeat units:**
```bash
nhmmer --cpu 16 --dna -o sample.DYZ1.nhmmer.txt --tblout sample.DYZ1.nhmmer.tab -E 1.60E-150 Y_DYZ1.cons.fa sample.chrY.fa
nhmmer --cpu 16 --dna -o sample.DYZ2.nhmmer.txt --tblout sample.DYZ2.nhmmer.tab -E 1.60E-150 Y_DYZ2.cons.fa sample.chrY.fa
bash runDYZ_by_hummerout.sh
```
**GC Content to check the boundary:**
```bash
samtools faidx sample.chrY.fasta
awk '{print $1"\t"$2}' sample.chrY.fasta.fai > sample.size
bedtools makewindows -g sample.size -w 100 | \
bedtools nuc -fi sample.chrY.fasta -bed stdin | grep -v "#" | cut -f1,2,3,5 > sample.100bp.GC
```
