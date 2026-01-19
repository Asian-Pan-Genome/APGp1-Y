#!/bin/bash

#SBATCH --job-name=discoVista
#SBATCH --partition=cpu64,cpu128
#SBATCH --cpus-per-task=4
#SBATCH --mem=10000
#SBATCH --output=discoVista.o
#SBATCH --error=discoVista.e

export WS_HOME=/share/home/zhanglab/user/liujing/Software
$WS_HOME/DiscoVista/src/utils/discoVista.py -a ../DE.samples.clade.txt -m 5 -p ./ -o DE_out -g OUT

nw_prune -v 03.MSY.iqtree.treefile $(cat 50Kb_wins/AMP2_57.sam) > AMP2_57.species.tre
Rscript calc_wrf_distance.R AMP2_57.gene_tree AMP2_57.species.tre AMP2_57.wrf_dis