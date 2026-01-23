## Y Chromosome Assembly Evaluation

### Error Detection Using NucFreq and Flagger

To identify potential misassemblies in Y chromosome assemblies, we used two complementary approaches:

- **NucFreq** (v0.1) was used to detect base-level discordance. HiFi reads were aligned and filtered (SAMtools flag 2308) to remove secondary and low-quality mappings. Regions showing ≥10% support for a secondary base in ≥5 positions per 500 bp window were flagged using `hetDetection.R`.
  
- **Flagger** (v0.3.2) was used for structural error detection based on read coverage anomalies. Y chromosome–specific regions were extracted from genome-wide Flagger results, including categories such as erroneous, collapsed, and duplicated regions.

The **intersection and union** of NucFreq- and Flagger-flagged regions were computed using **bedtools** `inter_merge.sh`

---

### Complex Region Evaluation with VerityMap and GAVISUNK

- **VerityMap** (v2.1.2) was used in `hifi-diploid` mode to detect assembly errors using PacBio HiFi reads. Regions with ≥80% discordant support were reported based on the `*_errors.tsv` output.


- **GAVISUNK** (v1.0.0) was used to validate haplotype-resolved assemblies using ONT reads (20-mer default `SUNK_len`). Two Y assemblies were used as independent haplotypes.

Representative visualizations from both tools are shown in *Supplementary Fig1. S3*, with some other results available under `/gavisunk`.

---

### Assembly Quality Scores: QV and GCI

- **QV scores** were computed using **Merqury**, based on k-mer completeness from HiFi reads.

- **GCI** (Genome Consistency Inspector; Chen et al., *Bioinformatics*, 2024) was used to quantify base-level structural continuity, combining HiFi and ONT alignments. Chromosome Y was evaluated using the following command:

```bash
python GCI.py -r $pat_asm \
  --hifi ${pat.winnowmap.hifi.bam} ${pat.minimap2.hifi.paf} \
  --nano ${pat.winnowmap.ont.bam} ${pat.minimap2.ont.paf} \
  --chrs ${sample}#Pat#chrY \
  -t $threads -p -it pdf

