# Y Chromosome Annotation Pipeline

This repository provides the annotation workflow, scripts, and key resources used for annotating **Y chromosomal subregions**, including satellites, amplicons, palindromes, genes, and repeats.

## Overview

The pipeline integrates public and custom tools to annotate the following features on `chrY` assemblies:

- Subregion classification via **coordinate liftover** from CHM13v2.0  
- Gene and pseudogene transfer via **Liftoff**  
- Repeat annotation with **RepeatMasker**  
- Satellite (DYZ1/DYZ2) detection using **k-mer**, **GC content**, and **HMMER**  
- Ampliconic region detection via **Winnowmap**-based alignment  
- Palindromic and IR structure identification via **self-alignment and Palindrover**  
- Manual curation of ambiguous regions

## Key Tools & Versions

- [nf-LO](https://github.com/evotools/nf-LO) v1.8.0  
- [Liftoff](https://github.com/agshumate/Liftoff) v1.6.3  
- [RepeatMasker](https://github.com/Dfam-consortium/RepeatMasker) v4.1.2 + Dfam 3.3  
- [Assembly_HSat2and3_v2.pl](https://github.com/altemose/chm13_hsat)  
- [HMMER](https://github.com/EddyRivasLab/hmmer) v3.4  
- [Winnowmap](https://github.com/marbl/Winnowmap) v2.03  
- [Palindrover](https://github.com/makovalab-psu/T2T_primate_XY/tree/main/palindrover_maf_align)  
- [Lastz](https://github.com/lastz/lastz) v1.04.00
- [R](https://www.r-project.org/) v4.1.3
- [chaintools](https://github.com/milkschen/chaintools) v0.1
- [paf2chain](https://github.com/AndreaGuarracino/paf2chain) v0.1.0
- [CrossMap](https://github.com/liguowang/CrossMap) v0.5.2

### Attribution and Copyright

The script `dotplot.colors.r` and `dotplot.X_ref.r` is adapted from  
**EDFig3a_dotplot_idy.R** in the [T2T-HG002Y project by Arang Rhie et al.](https://github.com/arangrhie/T2T-HG002Y), originally available at:  
https://github.com/arangrhie/T2T-HG002Y/blob/main/alignments/lastz/EDFig3a_dotplot_idy.R

The plotting style belong to the authors of the T2T-HG002Y project. Modifications in this repository were made solely to match our dataset and annotation structure.
