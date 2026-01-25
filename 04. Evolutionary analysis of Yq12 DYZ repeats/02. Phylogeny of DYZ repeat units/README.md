## Phylogeny of DYZ repeats units
All HSAT sequences (including the great apes of the outgroups) were identified in the section `02. Y chromosome annotations/05. Annotation of DYZ1 and DYZ2 arrays`.

### DYZ1: K-mer based neighbor joining (NJ) tree
#### Produce 10Kb-window bed of Ape HSat3
HSat3 repeats were classified into HSat1B associated and other HSat3 array, and the same goes for HSat1B repeats.
```
perl extract_species_hsat3.pl Ape.HSat1B_associated.HSat3.nonYq12.pos Ape.All_HSat3.anno
perl extract_species_hsat3.pl Ape.other_HSat3.pos Ape.All_HSat3.anno
perl extract_species_hsat3.pl CHM13.Yq12_HSat3.DYZ_block.bed Ape.All_HSat3.anno
```
#### Extract fasta
```
sbatch extract_hsat3_fa.sh
cat Gorilla.All_HSat3.fa Bonobo.All_HSat3.fa Chimpanzee.All_HSat3.fa Human.All_HSat3.fa > Ape.All_HSat3.fa
```
#### Extract other HSat3 (Downsampling) for kmer-analysis
```
perl substr_fasta.pl Ape.All_HSat3.anno Ape.All_HSat3.fa Selected.HSat3.list Selected.HSat3.anno
perl make_itol_anno.pl color.txt Selected.HSat3.anno Selected.HSat3.type_point_anno Selected.HSat3.spe_bar_anno
```
The final NJ trees for different kmer sizes were attached in the current directory. The tree shown in the main Figure. 2b is `Selected.HSat3.Kmer9.common_tab.mash.NJ.selected.nwk`, which further downsampled the 'Other HSat3 repeats'.
### DYZ2: Sequence alignment based maximum likelihood (ML) tree
phylogeny of DYZ2 repeats was based on the HSATI and AluY elements of HG002-Y.

```bash
#01 Alignment
mafft --thread 16 all.fa > all.align.fa
mkdir -p treeout
#02 Tree Construction
iqtree -s all.align.fa -T AUTO -bb 1000 -bnni -m TEST --prefix treeout/all.alu.align
```

