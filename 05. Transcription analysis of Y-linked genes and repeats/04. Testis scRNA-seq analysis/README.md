# Testis scRNA-seq Analysis Pipeline

This directory documents the single-cell RNA sequencing (scRNA-seq) analysis workflow used to characterize the transcriptional dynamics of DYZ and TSPY repeats in human testicular tissue.

## Overview

We utilized publicly available scRNA-seq datasets covering a broad age spectrum (21–76 years) to analyze germline expression patterns. The pipeline features a **customized quantification strategy** to distinguish between specific DYZ evolutionary subgroups (G1, G2, G3) and TSPY gene families within the T2T-CHM13v2 context.

## Key Tools & Versions

- Cell Ranger (v9.0.1)
- [scTE](https://github.com/JiekaiLab/scTE) (v1.0)
- Scanpy (v1.11.0)

## Analysis Workflow

### 1. Alignment & Quantification
* **Reference:** Reads were aligned to the complete **T2T-CHM13v2** reference genome using Cell Ranger.
* **Repeat Quantification (scTE):**
    * We constructed a **custom repeat annotation reference** to capture specific Y-chromosomal repeats.
    * **DYZ repeats:** Explicitly incorporated genomic coordinates for DYZ1 and DYZ2 subgroups (**G1, G2, G3**).
    * **TSPY genes:** TSPY-FAM197Y array genes were distinctly annotated as composite repeats to capture transcriptional output.

### 2. Quality Control & Preprocessing
Processed using **Scanpy** with the following criteria:
* **Doublet Removal:** Performed using **Scrublet**.
* **Filtering:**
    * Cells retained: > 800 detected genes.
    * Genes retained: Expressed in at least one cell.
* **Final Dataset:** 34,741 high-quality cells.

### 3. Integration & Dimensionality Reduction
To mitigate batch effects from different donor ages (21, 30, 42, 55, 66, 76 years):
* **Integration:** Performed using **Harmony** with default parameters.
* **Embedding:**
    * **PCA:** Harmony-corrected space used (`use_rep = 'X_pca_harmony'`).
    * **Nearest Neighbors:** `n_neighbors = 10`, `n_pcs = 50`.
    * **UMAP:** `min_dist = 0.3`, `spread = 0.8`.
* **Cell Typing:** Clusters annotated based on canonical markers from the human testis atlas (**Cui et al., 2025**).

### 4. DYZ1 lncRNA Quantification Logic
To specifically quantify the expression of DYZ1-derived lncRNAs:
1.  **Mapping:** The count matrix from scTE was mapped back to individual cells.
2.  **Normalization:** Repeat element expression was normalized against the total gene counts per cell.
3.  **Aggregation:** We calculated cumulative expression by summing raw counts of all repeat units belonging to each lineage (**G1, G2, G3**).
4.  **Transformation:** Aggregated counts were `log2(count + 1)` transformed.
5.  **Comparison:** All MSY euchromatic lncRNAs were processed using this identical strategy for comparative analysis.

### Data Availability
Adult testis single-cell RNA-seq datasets(Cui et al., 2025) include SRR15613722, SRR15613723, SRR15613729, SRR27645708, SRR27645721 and SRR27645730.
