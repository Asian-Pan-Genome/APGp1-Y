# Phylogeny Pipeline for DYZ repeats
## 01 HG002-based
### 1.1 DYZ1: K-mer Approach

- **Tools:** `kmer-db` (v1.11.1), `FastME` (v2.0)


### 1.2 DYZ2: Sequence Alignment Approach
phylogeny of DYZ2 based on HG002's HSATI and AluY elements in `02 Y chromosome annotations/05. Annotation of DYZ1 and DYZ2 arrays` Repeatmasker output .

* **Tools:** `MAFFT` (v7.505), `IQ-TREE` (v2.1.4)

```bash
#01 Alignment
mafft --thread 16 all.fa > all.align.fa

mkdir -p treeout

#02 Tree Construction
iqtree -s all.align.fa -T AUTO -bb 1000 -bnni -m TEST --prefix treeout/all.alu.align
```
## 02 APGp1-based


##
*Visualization performed with iTOL (v7.4).*
