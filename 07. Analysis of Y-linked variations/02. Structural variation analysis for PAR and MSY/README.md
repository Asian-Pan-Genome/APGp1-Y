# Filter out invalid PAR sequences and make the sequence list
@qingyang

# Construct MC pangenomes for PAR1 and PAR2 and perform variants decomposition
Here, use the command constructing the PAR1 pangenome as an example:
```
cactus-pangenome ./PAR1.js ./PAR1.seq.file --outDir ./CHM13_PAR1 --outName CHM13_PAR1 \
                 --reference CHM13_Mat \ # use the PAR1 sequence of CHM13 chromosome X as the reference, which was coded as `CHM13_Mat` here
                 --vcf --vcfReference CHM13_Mat \
                 --logFile ./CHM13_PAR1.log --workDir ./CHM13_PAR1.temp \
                 --mapCores 30 --indexCores 30 --mgMemory 150G --consMemory 150G --indexMemory 150G
```

# Extract and collapse SVs
Due to the conflict alignment of contigs, we should filter out records having zero allele count. Next, extract SV records:
```
bcftools view -c 1 CHM13_PAR1.vcf.gz -Ov -o CHM13_PAR1.filter.vcf
python scripts/split_vcfs_by_allele_length.py CHM13_PAR1.filter.vcf CHM13_PAR1.filter
```

Use [a new SV collapsing method](https://github.com/Asian-Pan-Genome/PanSVMerger) (here is the old version, please refer the repo for applying the lastest script), described in [our flagship paper](https://github.com/Asian-Pan-Genome/APGp1), to reduce redundancy in the SV representation:
```
python scripts/SV.merge.py CHM13_PAR1.filter.SVs.vcf CHM13_PAR1.filter.SVs.merge.vcf tmp.fa tmp uc.merge uc.merge.new CHM13_PAR1.filter.SVs.uncluster.vcf 8
```

Now, the file `CHM13_PAR1.filter.SVs.merge.vcf` could be used for downstream analysis.

# Calculate Hudson Fixation Index (HFst)
To quantify the population stratification for multiallelic SVs in haploid form, we calculated [HFst](https://doi.org/10.1093/genetics/132.2.583) with a custom script:
```
python scripts/get_allele_per_pos_for_per_sample_from_vcf.py CHM13_PAR1.filter.SVs.merge.vcf CHM13_PAR1.filter.SVs.merge
# Here one should provide a list file (tab-delimited) as: `sample_id\tsource\tpop`, where `source` could be APGp1, HPRCy1, HGSVC3, et al. `PAR1.id.list` file is an example.
# One should edit the script to work with their data. Here, we just calculate HFst comparing APGp1 samples with others.
python scripts/calculating_fst_from_vcf_bed.py CHM13_PAR1.filter.SVs.merge.vcf.bed PAR1.id.list CHM13_PAR1.filter.SVs.merge.vcf.bed
```
The resulting file `CHM13_PAR1.filter.SVs.merge.vcf.bed.tsv` could be used for prioritizing SVs to check population differentiation.
