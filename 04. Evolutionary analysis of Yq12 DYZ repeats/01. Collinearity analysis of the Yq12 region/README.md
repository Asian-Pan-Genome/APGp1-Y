# 01. Collinearity Analysis of the Yq12 Region

This pipeline assesses the synteny of DYZ arrays between APGp1 individuals and HG002-Y.

### Prerequisites
- **NGenomeSyn** (v1.43) - [Link](https://github.com/hewm2008/NGenomeSyn)
- **Reference Annotation:** `chm13v2.0_censat_v2.1.bed`
- **minimap2** (v)

### Workflow

#### 1. Generate Masked References
To minimize misalignment, we generate two masked reference genomes based on HG002-Y DYZ annotations.
* **Ref 1:CHM13.chrY.maskDYZ1.fa** Masks DYZ1 regions.
* **Ref 2:CHM13.chrY.maskDYZ1.fa** Masks DYZ2 regions.

#### 2. Assemblies are aligned independently to both masked references.
···
minimap2 -t8 -cx asm5 --cs  CHM13.chrY.maskDYZ1.fa ${sample}.chrY.fa  > ${sample}_chrY.map2chm13.paf
···
#### 3. Synteny is visualized using NGenomeSyn.


