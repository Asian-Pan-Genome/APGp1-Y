#!/bin/bash

#SBATCH --job-name=02_filter
#SBATCH --partition=cpu64,cpu128
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --output=02_filter.o
#SBATCH --error=02_filter.e

source ~/Software/cactus-bin-v2.7.2/cactus_env/bin/activate
/share/home/zhanglab/user/liujing/Software/cactus-bin-v2.7.2/bin/hal2maf --onlyOrthologs --noDupes --unique --maxBlockLen 10000 --noAncestors --refGenome CHM13 ../../Cactus/phase2.chrYs.chm13.full.hal phase2.chrYs.chm13.maf

#extract euchromatin maf
#block length >= 1000bp && missing sites <= 0.2 && >=10 parsimony informative sites
perl maf_filter.pl CHM13.Euchromatin.bed phase2.chrYs.chm13.maf phase2.chrYs.chm13.euchromatin.filter.maf 1000 10 0.2
