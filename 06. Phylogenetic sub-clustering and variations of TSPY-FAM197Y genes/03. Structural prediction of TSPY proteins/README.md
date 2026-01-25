# Structural Prediction 

This section outlines the computational workflow used to model the 3D structures of TSPY proteins and assess the functional impact of the O2a-specific mutation (p.E85G) and exonic variants.



## Key Tools & Versions

- [AlphaFold3](https://github.com/google-deepmind/alphafold3) (Abramson et al., 2024) - 3D Structure Prediction
- [DeepTrio](https://github.com/tiancj2016/DeepTrio) v1.0.0 (Hu et al., 2022) - PPI Prediction

## Analysis Workflow

### 1. 3D Structure Prediction
Predicted 3D structures for TSPY subgroups were generated using **AlphaFold3**. These models served as the basis for understanding structural variations between haplogroups.

### 2. Protein-Protein Interaction (PPI) Modeling
To evaluate the impact of the **O2a specific mutation (p.E85G)**, we compared the interaction potential of Reference-type vs. Mutant-type TSPY2 against three established partners:
* **AR** (Androgen Receptor)
* **ERG** (ETS-related gene)
* **FOXA1** (Forkhead box protein A1)

```
python visual_DeepTrio.py --protein1 TSPY2_Ref.pdb --protein2 AR.pdb --out output_ref
python visual_DeepTrio.py --protein1 TSPY2_Mut.pdb --protein2 AR.pdb --out output_mut
```
