# Structural Prediction & Functional Analysis of TSPY

This section outlines the computational workflow used to model the 3D structures of TSPY proteins and assess the functional impact of the O2a-specific mutation (p.E85G) and exonic variants.

## Overview

The analysis focuses on two main aspects:
1.  **Protein Structure & Interaction:** Predicting 3D structures and evaluating how the p.E85G mutation affects interactions with key male germline/prostate cancer proteins (AR, ERG, FOXA1).
2.  **Transcription Factor Binding:** Assessing potential regulatory effects of the O2a haplogroup-specific variant (T>C) in the first exon of TSPY2.

## Key Tools & Versions

- [AlphaFold3](https://github.com/google-deepmind/alphafold3) (Abramson et al., 2024) - 3D Structure Prediction
- [DeepTrio](https://github.com/tiancj2016/DeepTrio) v1.0.0 (Hu et al., 2022) - PPI Prediction
- [FIMO](https://meme-suite.org/meme/tools/fimo) (MEME Suite) - Motif Scanning
- [HOCOMOCOv11](https://hocomoco11.autosome.ru/) - Human Transcription Factor Motif Database

## Analysis Workflow

### 1. 3D Structure Prediction
Predicted 3D structures for TSPY subgroups were generated using **AlphaFold3**. These models served as the basis for understanding structural variations between haplogroups.

### 2. Protein-Protein Interaction (PPI) Modeling
To evaluate the impact of the **O2a specific mutation (p.E85G)**, we compared the interaction potential of Reference-type vs. Mutant-type TSPY2 against three established partners:
* **AR** (Androgen Receptor)
* **ERG** (ETS-related gene)
* **FOXA1** (Forkhead box protein A1)

**Execution:**
PPIs were predicted using the structure-informed deep learning framework **DeepTrio**.

```bash
# Script usage (visual_DeepTrio.py)
# Model: Pre-trained human model
# Settings: Default
python visual_DeepTrio.py --protein1 TSPY2_Ref.pdb --protein2 AR.pdb --out output_ref
python visual_DeepTrio.py --protein1 TSPY2_Mut.pdb --protein2 AR.pdb --out output_mut
