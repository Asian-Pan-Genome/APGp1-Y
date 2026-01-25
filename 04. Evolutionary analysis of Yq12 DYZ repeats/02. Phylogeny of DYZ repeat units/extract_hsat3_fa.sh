#!/bin/bash

#SBATCH --job-name=extract_fa
#SBATCH --partition=cpu64
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --output=extract_fa.o
#SBATCH --error=extract_fa.e

bedtools getfasta -fi Gorilla.fa -bed Gorilla.All_HSat3.bed -fo Gorilla.All_HSat3.fa
bedtools getfasta -fi Bonobo.fa -bed Bonobo.All_HSat3.bed -fo Bonobo.All_HSat3.fa
bedtools getfasta -fi Chimpanzee.fa -bed Chimpanzee.All_HSat3.bed -fo Chimpanzee.All_HSat3.fa
bedtools getfasta -fi Human.fa -bed Human.All_HSat3.bed -fo Human.All_HSat3.fa

