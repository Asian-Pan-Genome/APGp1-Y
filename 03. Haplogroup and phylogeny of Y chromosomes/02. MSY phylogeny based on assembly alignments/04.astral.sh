#!/bin/bash

#SBATCH --job-name=MSY_iqtree
#SBATCH --partition=cpu64,cpu128
#SBATCH --cpus-per-task=32
#SBATCH --mem=50000
#SBATCH --output=MSY_iqtree.o
#SBATCH --error=MSY_iqtree.e


for i in {1..1657}; do nw_ed Blocks/Block$i/Block$i.treefile 'i & b<10' o > Blocks/Block$i/Block$i.treefile.collapsed; cat Blocks/Block$i/Block$i.treefile.collapsed >> raw.blocks.collapsed_tree_files; done

cat Blocks/Block*/Block*.treefile.collapsed > Eu.RM_PAR_TSPY.blocks.collapsed_tree_files

java -jar ~/Software/ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i Eu.RM_PAR_TSPY.blocks.collapsed_tree_files -o Eu.RM_PAR_TSPY.blocks.collapsed.species_pp.tre