# Structural Prediction 

This section outlines the computational workflow used to model the 3D structures of TSPY proteins and assess the functional impact of the O2a-specific mutation (p.E85G) and exonic variants.

## Key Tools & Versions

- [AlphaFold3](https://github.com/google-deepmind/alphafold3) (Abramson et al., 2024) - 3D Structure Prediction
- [DeepTrio](https://github.com/huxiaoti/deeptrio) v1.0.0 (Hu et al., 2022) - PPI Prediction

## Analysis Workflow

### 1. 3D Structure Prediction
Predicted 3D structures for TSPY subgroups were generated using **AlphaFold3**. These models served as the basis for understanding structural variations between haplogroups.

### 2. Protein-Protein Interaction (PPI) Modeling
To evaluate the impact of the **O2a specific mutation (p.E85G)**, we compared the interaction potential of Reference-type vs. Mutant-type TSPY2 against three established partners:
* **AR** (Androgen Receptor)
* **ERG** (ETS-related gene)
* **FOXA1** (Forkhead box protein A1)

```
python ~/software/deeptrio/main.py -p1 tspy2.fa -p2 ERG.fa   -m ~/software/deeptrio/scripts/DeepTrio/models/visualization/DeepTrio_acc_human.h5 -o TSPY2_ERG
python ~/software/deeptrio/main.py -p1 tspy2_O.fa -p2 ERG.fa   -m ~/software/deeptrio/scripts/DeepTrio/models/visualization/DeepTrio_acc_human.h5 -o TSPY2O2_ERG
python ~/software/deeptrio/visual_DeepTrio2.py -p1 tspy2_O.fa -p2 ERG.fa -m ~/software/deeptrio/scripts/DeepTrio/models/visualization/DeepTrio_acc_human.h5
python ~/software/deeptrio/visual_DeepTrio2.py -p1 tspy2.fa -p2 ERG.fa -m ~/software/deeptrio/scripts/DeepTrio/models/visualization/DeepTrio_acc_human.h5
python plotline.py TSPY2_O2a_with_respect_to_ERG_heatmap_data.txt TSPY2_with_respect_to_ERG_heatmap_data.txt ERG.pdf
```
