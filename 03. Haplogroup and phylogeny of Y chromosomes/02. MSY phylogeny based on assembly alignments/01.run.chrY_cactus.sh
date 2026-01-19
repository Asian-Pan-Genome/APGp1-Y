#!/bin/bash

#SBATCH --job-name=chrY.cactus
#SBATCH --partition=cpu128
#SBATCH --cpus-per-task=16
#SBATCH --mem=80000
#SBATCH --output=chrY.cactus.o
#SBATCH --error=chrY.cactus.e

cactus-pangenome ./js-CHM13 phase2.chrYs.list --outName phase2.chrYs.chm13 --outDir phase2.chrYs.chm13 --reference CHM13 CN1 GRCh38 --filter 20 --giraffe clip filter --vcf --vcfReference CHM13 CN1 GRCh38 --viz --odgi --chrom-vg clip filter --chrom-og --gbz clip filter full --gfa clip full --logFile phase2.chrYs.chm13.log --mgCores 16 --mapCores 16 --consCores 16 --indexCores 16 2> phase2.chrYs.chm13.stderr