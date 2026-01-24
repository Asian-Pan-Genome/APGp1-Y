# 05 Yq12 (DYZ1 / DYZ2) Annotation

## 5.1 Broad Region Identification

### DYZ1 (HSat3 Homologs)
* **5.11** [`Assembly_HSat2and3_v2.pl`](https://github.com/altemose/chm13_hsat)
* **5.12 Great Ape HSat3 Homologs:**
- Used [CHM13v2.0 annotations]() as the reference.
- Calculated pairwise distances between Ape HSat3 and Human HG002 repeats.
    * Tool: `kmer-db` (v1.11.1) with **k=9**.

### DYZ2 (HSat1 Subfamilies)
Regions were classified based on RepeatMasker output:
* **HSat1A:** Regions identified as 'SAR'.
* **HSat1B (DYZ2 Units):** Defined as a combination of:
    `HSATI` + `AluY` (same orientation) + `(AT)n` repeats.
```bash
RepeatMasker -pa 8  -species human -e ncbi -dir output_dir -gff sample.chrY.fasta
```

## 5.2 Precise Unit Annotation (HMM)
To define exact boundaries for individual repeat units, we performed a Profile HMM search.
```bash
nhmmer --cpu 16 --dna -o sample.DYZ1.nhmmer.txt --tblout sample.DYZ1.nhmmer.tab -E 1.60E-150 Y_DYZ1.cons.fa sample.chrY.fa
nhmmer --cpu 16 --dna -o sample.DYZ2.nhmmer.txt --tblout sample.DYZ2.nhmmer.tab -E 1.60E-150 Y_DYZ2.cons.fa sample.chrY.fa
bash runDYZ_by_hummerout.sh
```

