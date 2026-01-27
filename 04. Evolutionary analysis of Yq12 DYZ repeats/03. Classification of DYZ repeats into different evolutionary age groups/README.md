## Classification of Evolutionary Age Groups (DYZ1 & DYZ2)

To delineate internal subgroups within the Yq12 region, we analyzed sequences from all 85 gapless APGp1 Y chromosomes, supplemented by HG002-Y and CN1-Y.

### 1. Data Processing & Clustering
Initial processing was performed using **VSEARCH** (v2.29.0).
* **Filtering:** Redundant sequences and fragmented units were removed (Length thresholds: DYZ1 < 1,000 bp; DYZ2 HSATI-AluY < 800 bp).
* **Clustering:** High-confidence core subtype units were identified using `--cluster_fast` with the following identity thresholds:
    * **DYZ1:** --id 0.99
    * **DYZ2:** --id 0.993

**DYZ2 Alu and HSATI:**
```
vsearch --fastx_filter all.Alu_sat.fa --fastaout all.Alu_sat.filter.fa --fastq_minlen 800
vsearch --derep_fulllength all.Alu_sat.filter.fa --output all.Alu_sat.uniq.fa --sizeout --uc filter.dup.info
vsearch --cluster_fast all.Alu_sat.uniq.fa --id 0.993 --iddef 0  --centroids all.Alu_sat.uniq.993.cen.fa --uc filter.993cen.u
```

### 2. Phylogenetic Reconstruction
Maximum likelihood trees were constructed using the **GTR+F+G4** substitution model (selected for consistency with HG002-Y analysis).

* **DYZ1 Strategy:** Restricted to the **Yq12 HSat3-A6 lineage**. Other HSat3 subfamilies were excluded due to length variation affecting alignment quality.
* **DYZ2 Strategy:** Included outgroups to resolve evolutionary origin:
    * T2T-CHM13v2 acrocentric HSat1B repeats.
    * Homologous sequences from Great Apes.
    * *Validation:* Topology consistency was verified by constructing separate trees for isolated HSATI and AluY components (see Fig. S10).
```
mafft --thread 16 all.fa > all.align.fa
mkdir -p treeout
iqtree -s all.align.fa -T AUTO -bb 1000 -bnni -m  GTR+F+G4 --prefix treeout/all.alu.align
```

### 3. PCA Analysis (K-mer based)
To resolve sequence heterogeneity without multiple sequence alignment, we employed a k-mer based dimensionality reduction.
```
python runmodule.py
python plot.py
```

---

### 4. Definition of Age Groups (G1, G2, G3)
Based on the integration of phylogenetic topology, PCA clustering, and genomic spatial distribution, we stratified units into three lineages.

#### DYZ1 Subgroups
| Group | Description & Evidence |
| :--- | :--- |
| **G1 (Ancestral)** | • **PCA:** Distinct cluster separated from the main expansion.<br>• **Phylogeny:** Occupies the basal position within the Yq12 HSat3-A6 clade.<br>• **Location:** Predominantly localized within the **distal terminal block**. |
| **G2** | • **Phylogeny:** Cluster immediately adjacent to G1 in the comprehensive alignment-based tree. |
| **G3 (Main)** | • Represents the vast majority of the array (Main expansion events). |

#### DYZ2 Subgroups
| Group | Description & Evidence |
| :--- | :--- |
| **G1 (Ancestral)** | • **PCA/Phylogeny:** Distinct separation; clusters with HSat1B from autosomes.<br>• **Location:** Enriched in the **terminal block**. |
| **G2** | • Differentiated from G3 based on internal **AluY divergence**.<br>• Verified by specific clustering patterns in AluY-based trees and PCA. |
| **G3** | • Differentiated from G2 based on internal **AluY divergence**. |
