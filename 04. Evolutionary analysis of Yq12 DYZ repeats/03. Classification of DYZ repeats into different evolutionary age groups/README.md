## Classification of Evolutionary Age Groups (DYZ1 & DYZ2)

To delineate internal subgroups within the Yq12 region, we analyzed repeat units
from 85 gapless APGp1 Y chromosomes, supplemented by HG002-Y and CN1-Y.

### 1. Data processing and clustering

Initial processing was performed using **VSEARCH v2.29.0**. Redundant sequences
and fragmented units were removed. The minimum retained lengths were 1,000 bp
for DYZ1 and 800 bp for DYZ2 HSATI-AluY units. High-confidence core units were
clustered with `--cluster_fast` at identities of 0.99 for DYZ1 and 0.993 for
DYZ2.

Example for DYZ2:

```bash
vsearch --fastx_filter all.Alu_sat.fa \
  --fastaout all.Alu_sat.filter.fa --fastq_minlen 800
vsearch --derep_fulllength all.Alu_sat.filter.fa \
  --output all.Alu_sat.uniq.fa --sizeout --uc filter.dup.info
vsearch --cluster_fast all.Alu_sat.uniq.fa \
  --id 0.993 --iddef 0 --centroids all.Alu_sat.uniq.993.cen.fa \
  --uc filter.993cen.u
```

### 2. Phylogenetic reconstruction

Maximum-likelihood trees were constructed under the **GTR+F+G4** substitution
model. For DYZ1, the analysis was restricted to the Yq12 HSat3-A6 lineage,
because length variation among other HSat3 subfamilies affected alignment
quality. The DYZ2 analysis included T2T-CHM13v2 acrocentric HSat1B repeats and
homologous sequences from great apes as outgroups. Topological consistency was
also assessed using separate HSATI- and AluY-based trees.

```bash
mafft --thread 16 all.fa > all.align.fa
mkdir -p treeout
iqtree -s all.align.fa -T AUTO -bb 1000 -bnni \
  -m GTR+F+G4 --prefix treeout/all.alu.align
```

### 3. Initial k-mer PCA

Sequence heterogeneity was initially examined using an alignment-free k-mer
count matrix followed by principal component analysis (PCA). See `runmodule.py`
and `plot.py` for the original analysis.

### 4. Definition of age groups (G1, G2 and G3)

The age-group assignments were first established by integrating phylogenetic
topology, sequence-space analyses, and genomic position.

#### DYZ1 subgroups

| Group | Description and evidence |
| --- | --- |
| **G1 (ancestral)** | Forms a distinct sequence-space cluster, occupies a basal position within the Yq12 HSat3-A6 clade, and is predominantly located in the distal terminal block. |
| **G2** | Forms the phylogenetic group immediately adjacent to G1 in the comprehensive alignment-based tree. |
| **G3 (main)** | Contains most repeat units and represents the principal array expansion. |

#### DYZ2 subgroups

| Group | Description and evidence |
| --- | --- |
| **G1 (ancestral)** | Separates from the main DYZ2 expansion, clusters with autosomal HSat1B repeats, and is enriched in the terminal block. |
| **G2** | Distinguished from G3 primarily by divergence of the internal AluY sequence. |
| **G3** | Represents the alternative major AluY-defined lineage. |

### 5. Independent validation of the predefined G2/G3 classifications

After completing the classifications above, we independently tested whether the
predefined **G2 and G3** subfamilies could be distinguished using an alternative
alignment-free representation implemented in
`validate_age_groups_by_kmer_pcoa.py`. This final validation does not rely on the
multiple-sequence alignments or monomer clustering used to establish the
classifications.

Before running this validation script, DYZ1 repeat units shorter than 3.5 kb and
DYZ2 Alu-HSAT units shorter than 800 bp were removed, and fully redundant
sequences were dereplicated. Independently selected sequence batches were saved
as separate filtered, unique FASTA files and analyzed separately, as shown in
`run_validation_examples.sh`. The validation script uses the predefined
annotation table and evaluates only G2 and G3 records present in each input
FASTA.

Specifically, sample IDs were randomly selected to form independent validation
batches. Repeat units belonging to each selected sample were extracted from the
complete DYZ datasets. DYZ1 units shorter than 3.5 kb and DYZ2 Alu-HSAT units
shorter than 800 bp were discarded. Fully identical sequences were subsequently
dereplicated, producing one filtered `.uniq.fa` file for each selected sample.
These preprocessed FASTA files were then analyzed independently in the final
G2/G3 validation.

For each selected k-mer size, the validation workflow:

1. reads one prefiltered, dereplicated sequence batch and its predefined labels;
2. retains the G2 and G3 records represented in that FASTA;
3. extracts canonical k-mer presence/absence profiles at the selected k values;
4. calculates pairwise Jaccard similarities and converts them to Mash distances;
5. performs principal coordinates analysis (PCoA) on the distance matrix;
6. constructs an average-linkage (UPGMA) tree;
7. scans alternative cluster numbers using Silhouette, Calinski-Harabasz and
   Davies-Bouldin statistics;
8. compares the optimal unsupervised clusters with the predefined G2/G3 labels
   using the adjusted Rand index (ARI); and
9. measures how well G2/G3 labels can be predicted in PCoA space using
   cross-validated k-nearest-neighbor classification and a confusion matrix.

Running the independently prepared FASTA batches at multiple k-mer sizes
provides a sensitivity analysis. G2/G3 separation is considered robust when
validation statistics and confusion-matrix patterns remain consistent across
both input batches and k values rather than depending on one batch or selected k.

#### Software requirements

- Python 3.9 or newer
- NumPy
- pandas
- SciPy
- scikit-learn
- Matplotlib

Install the Python dependencies with:

```bash
python -m pip install -r requirements.txt
```

#### Input formats

Large FASTA inputs are not included in this repository. Users should prepare a
strictly length-filtered and fully dereplicated FASTA file containing one repeat
unit per record. DYZ1 units must be at least 3.5 kb and DYZ2 Alu-HSAT units must
be at least 800 bp:

```text
>C001-CHA-E01_DYZ1_2_1
ACGT...
>C001-CHA-E01_DYZ1_2_2
ACGT...
```

The annotation file is a headerless, two-column TSV. Column 1 must exactly match
the complete FASTA header after `>`; column 2 contains the predefined age group:

```text
C001-CHA-E01_DYZ1_2_1	G2
C001-CHA-E01_DYZ1_2_2	G2
C001-CHA-E01_DYZ1_2_4	G2
```

#### Example commands

```bash
python validate_age_groups_by_kmer_pcoa.py \
  --fasta KOR08.DYZ1.uniq.fa \
  --annotations DYZ1.anno.tsv \
  --outdir KOR08_DYZ1 \
  --k_values 15,21,25,31 \
  --max_clusters 30

python validate_age_groups_by_kmer_pcoa.py \
  --fasta C076-CHA-NE16.Alu_SAT.uniq.fa \
  --annotations DYZ2.anno.tsv \
  --outdir C076-CHA-NE16_DYZ2 \
  --k_values 15,21,25,31 \
  --max_clusters 30
```

The workflow computes an all-by-all distance matrix and an eigendecomposition;
therefore, memory and runtime scale approximately quadratically with the number
of repeat units. The validation should be run on filtered, nonredundant core
units rather than all raw repeat copies.

#### Main outputs

For every input FASTA batch and k-mer size, the script writes:

| Output | Description |
| --- | --- |
| `summary.json` | Main G2/G3 validation statistics, including ARI and KNN accuracy |
| `pcoa_by_age_group.pdf` | PCoA projection colored by predefined age group |
| `pcoa_and_clusters.tsv` | PCoA coordinates and optimal cluster assignment |
| `cluster_number_scan.tsv` | Metrics across candidate cluster numbers |
| `cluster_scan_metrics.pdf` | Silhouette and Davies-Bouldin profiles |
| `knn_confusion_matrix.tsv` | Cross-validated age-group confusion matrix |
| `tree.nwk` | UPGMA tree in Newick format |
| `itol_age_group_colorstrip.txt` | iTOL color-strip annotation |
| `mash_dist.npz` | Compressed Mash distance matrix |
