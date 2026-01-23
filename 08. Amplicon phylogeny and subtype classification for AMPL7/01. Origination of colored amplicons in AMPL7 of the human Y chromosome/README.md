### Step1. Curated AMPL7 annotations

`Amplicon annotations.zip`

#### Dotplot of self-alignments for AMPL7

`bash AMPL7.self-align_dotplot.sh`

### Step2. Annotate the amplicons for ape-Ys, for example, blue amplicon:
#### extract amplicon sequences for HG002-Y
```
bedtools getfasta -s -nameOnly -fi HG002.chrY.fa -bed HG002.chrY.ampl7.phylo_anno.bed -fo HG002.chrY.ampl7.phylo_anno.fa
minimap2 -cx asm20 -t2 --cs Bonobo.chrY.fa HG002-G2_2.fa > Bonobo.HG002.paf
perl convert_paftobed.pl Bonobo.HG002.paf 10000 Bonobo.HG002.bed
```
### Step3. ML tree construction, for example, RED:
```
mafft --thread 16 All_RED.fasta > All_RED.aligned.fasta
clipkit All_RED.aligned.fasta -m gappy -o All_RED.trimmed.fasta
iqtree -s All_RED.trimmed.fasta -T AUTO -bb 1000 -bnni -m TEST --prefix All_RED.aligned_trimmed
iqtree -s All_RED.aligned.fasta -T AUTO -bb 1000 -bnni -m TEST --prefix All_RED.aligned_bb1000
iqtree -s All_RED.aligned.fasta -T AUTO -b 100 -m TEST --prefix All_RED.aligned_b100
```
