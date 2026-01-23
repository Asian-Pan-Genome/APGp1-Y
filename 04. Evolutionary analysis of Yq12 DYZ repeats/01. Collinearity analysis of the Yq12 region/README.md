# 01. Collinearity Analysis of the Yq12 Region

This pipeline assesses the synteny of DYZ arrays between APGp1 individuals and HG002-Y.

### Prerequisites
- [**NGenomeSyn**](https://github.com/hewm2008/NGenomeSyn) (v1.43)
- [**Minimap2**](https://github.com/lh3/minimap2) (v2.26)
- **Reference Annotation:** [`chm13v2.0_censat_v2.1.bed`](https://github.com/marbl/CHM13)


### Workflow

#### 1. Generate Masked References
To minimize misalignment, we generate two masked reference genomes based on HG002-Y DYZ annotations.
* **Ref 1:** Masks DYZ1 regions.
* **Ref 2:** Masks DYZ2 regions.

#### 2. Assemblies are aligned independently to both masked references.
```bash
minimap2 -t8 -cx asm5 --cs  HG002.maskDYZ1.fa ${sample}.chrY.fa  > ${sample}_chrY.map2chm13DYZ2.paf

minimap2 -t8 -cx asm5 --cs  HG002.maskDYZ2.fa ${sample}.chrY.fa  > ${sample}_chrY.map2chm13DYZ1.paf
```
#### 3. Synteny is visualized using NGenomeSyn.


