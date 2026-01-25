# Short-read based Copy Number Estimation of TSPY

This directory details the pipeline used to estimate the copy number of TSPY protein-coding genes from short-read sequencing data, applied to a prostate cancer cohort.

## Overview

To accurately quantify TSPY copy number variations (CNV) in datasets lacking long-read assemblies (e.g., the prostate cancer cohort from **Li et al., 2020**), we developed a depth-based estimation workflow.

**Validation Strategy:**
The accuracy of this method was first validated using APGp1 samples. We compared the estimated copy numbers derived from Illumina short reads against the "ground truth" counts obtained from their corresponding gapless Y chromosome assemblies.

## Analysis Workflow

### 1. Alignment & Preprocessing
* **Reference:** T2T-CHM13v2.0
* **Alignment:** Paired-end reads aligned using **BWA-MEM** with default parameters.
* **Post-processing:**
    * Sorting and indexing via **SAMtools**.
    * Duplicate marking via **Picard**.

### 2. Copy Number Estimation Strategy
We utilized a **normalized read depth approach** to calculate copy numbers:
1.  **Depth Calculation:**
    * Calculate average sequencing depth across the **TSPY array region**.
    * Calculate average sequencing depth across **X-degenerate regions (XDRs)**. XDRs serve as a stable normalization baseline as they permit unique mapping of short reads.
2.  **Normalization Logic:**
    The raw depth ratio is scaled relative to the known TSPY copy number in the HG002-Y reference assembly.
    **Formula:** Estimated CN = (Depth_TSPY / Depth_XDR) × Scaling_Factor_HG002

The prostate cancer cohort short-read sequencing data(Li et al., 2020) were obtained from the Genome Sequence Archive for Human (GSA-Human; http://bigd.big.ac.cn/gsa-human), under accession number PRJCA001124.
