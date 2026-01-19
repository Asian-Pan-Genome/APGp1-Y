#!/bin/bash

#SBATCH --job-name=MSY_iqtree
#SBATCH --partition=cpu64,cpu128
#SBATCH --cpus-per-task=32
#SBATCH --mem=50000
#SBATCH --output=MSY_iqtree.o
#SBATCH --error=MSY_iqtree.e

perl extract_fasta.pl phase2.chrYs.chm13.euchromatin.filter.maf MSY.TSPY_RM.fasta phase2.chrYs.chm13.euchromatin.MSY.fasta_stat phase2.chrYs.chm13.euchromatin.MSY.fasta.partition

iqtree -s MSY.TSPY_RM.fasta -T AUTO -bb 1000 -m TEST --prefix MSY