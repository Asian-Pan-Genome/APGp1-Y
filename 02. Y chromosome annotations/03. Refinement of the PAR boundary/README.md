# 03 PAR Boundary Refinement
```bash
lastz sample.chrX.fasta sample.chrY.fasta --filter=identity:80 --filter=nmatch:400 --hspthresh=36400 > anchors
lastz sample.chrX.fasta sample.chrY.fasta --segments=anchors --filter=nmatch:1000 --allocate:traceback=800M --format=general > align.dat
perl -lane 'if($F[4] eq "-"){($F[1], $F[2])=($F[2], $F[1])} print join("\t", @F)' align.dat > align.mod
samtools faidx sample.chrY.fasta
samtools faidx sample.chrX.fasta
Rscript dotplot.X_ref.r sample.chrX.fasta.fai sample.chrY.fasta.fai align.mod sample.subregion.bed.anno sample.XY.dotplot.pdf
```
