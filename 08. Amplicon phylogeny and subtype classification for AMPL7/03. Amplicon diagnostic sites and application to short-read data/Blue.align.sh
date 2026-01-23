#!/bin/bash

#SBATCH --job-name=Blue
#SBATCH --partition=cpu64,cpu128
#SBATCH --cpus-per-task=16
#SBATCH --mem=10000
#SBATCH --output=Blue.o
#SBATCH --error=Blue.e

sed -i 's/\@/\-/g' Blue.amplicon_type.fasta

mafft --thread 16 Blue.amplicon_type.fasta > Blue.amplicon_type.aligned.fasta

