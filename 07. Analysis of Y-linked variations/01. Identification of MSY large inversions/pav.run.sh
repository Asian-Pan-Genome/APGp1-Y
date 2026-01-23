#!/bin/bash

#SBATCH --job-name=Y_PAV2
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --partition=cpu128
#SBATCH --mem=40g
#SBATCH --output=Y_PAV.o
#SBATCH --error=Y_PAV.e

date
singularity run --bind "$(pwd):$(pwd)" pav_latest.sif -c 12
date
