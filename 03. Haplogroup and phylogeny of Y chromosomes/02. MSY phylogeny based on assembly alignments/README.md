### step1. 01.run.chrY_cactus.sh
Run cactus-pangenome to generate .HAL alignment files and .vcf variant files, using all 206 Y chromosomes, comprising 160 APGp1 samples, 44 HPRCy1/HGSVC2 samples(Hallast et al., 2023b), HG002 (CHM13; Rhie et al., 2023), and CN1(Yang et al., 2023). 

`cactus-pangenome ./js-CHM13 phase2.chrYs.list --outName phase2.chrYs.chm13 --outDir phase2.chrYs.chm13 --reference CHM13 CN1 GRCh38 --filter 20 --giraffe clip filter --vcf --vcfReference CHM13 CN1 GRCh38 --viz --odgi --chrom-vg clip filter --chrom-og --gbz clip filter full --gfa clip full --logFile phase2.chrYs.chm13.log --mgCores 16 --mapCores 16 --consCores 16 --indexCores 16 2> phase2.chrYs.chm13.stderr`

Note that, the MC pan-genome graph for the PAR were sepatately generated using 206 pairs of X and Y PAR sequences.

### step2. 02.maf_filter.sh
1. Extract alignment files

`/share/home/zhanglab/user/liujing/Software/cactus-bin-v2.7.2/bin/hal2maf --onlyOrthologs --noDupes --unique --maxBlockLen 10000 --noAncestors --refGenome CHM13 ../../Cactus/phase2.chrYs.chm13.full.hal phase2.chrYs.chm13.maf`

2. Extract and filter euchromatin maf: block length >= 1000bp && missing sites <= 0.2 && >=10 parsimony informative sites

`perl maf_filter.pl CHM13.Euchromatin.bed phase2.chrYs.chm13.maf phase2.chrYs.chm13.euchromatin.filter.maf 1000 10 0.2`

Remove the blocks from PARs, TSPY array, CEN, AMPL7 and Yq12: MSY.euchromatin.filtered.maf_blocks

### step3. 03.iqtree.sh

`perl extract_fasta.pl phase2.chrYs.chm13.euchromatin.filter.maf MSY.TSPY_RM.fasta phase2.chrYs.chm13.euchromatin.MSY.fasta_stat
phase2.chrYs.chm13.euchromatin.MSY.fasta.partition`

Input: <phase2.chrYs.chm13.euchromatin.filter.maf>; outputs: <MSY.TSPY_RM.fasta> <MSY.TSPY_RM.fasta_stat> <MSY.TSPY_RM.fasta.partition>

`iqtree -s MSY.TSPY_RM.fasta -T AUTO -bb 1000 -m TEST --prefix 03.MSY.iqtree`

### step4. 04.astral.sh

1. Generate ML tree for each block in MSY.euchromatin.filtered.maf_blocks, for example:

`iqtree -s ../Blocks/Block1201/Block1201.fasta -T AUTO -bb 1000 -bnni -m TEST --prefix ../Blocks/Block1201/Block1201`

2. Tree collapse and merge

`for i in {1..1657}; do nw_ed Blocks/Block$i/Block$i.treefile 'i & b<10' o > Blocks/Block$i/Block$i.treefile.collapsed; cat Blocks/Block$i/Block$i.treefile.collapsed >> raw.blocks.collapsed_tree_files; done`

3. Run astral for coalescent tree

`cat Blocks/Block*/Block*.treefile.collapsed > Eu.RM_PAR_TSPY.blocks.collapsed_tree_files`

`java -jar ~/Software/ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i Eu.RM_PAR_TSPY.blocks.collapsed_tree_files -o 04.MSY.astral.tre`

### step5. 05.discoVista .sh

1. #stimate phylogenic discordance for the DE node between concatenation and coalescent trees 

`export WS_HOME=/share/home/zhanglab/user/liujing/Software`

`$WS_HOME/DiscoVista/src/utils/discoVista.py -a DE.samples.clade.txt -m 5 -p ./ -o DE_out -g OUT`

The 'estimated_gene_trees.tree' is the block gene trees; the 'estimated_species_tree.tree' is the iqtree.ml.tree generated above

2. Estimate wrf_distance for each 50Kb window, for example for the 57th window of AMPL2:

`nw_prune -v 03.MSY.iqtree.treefile $(cat 50Kb_wins/AMP2_57.sam) > AMP2_57.species.tre`

`Rscript calc_wrf_distance.R AMP2_57.gene_tree AMP2_57.species.tre AMP2_57.wrf_dis`

The window gene tree was generated with iqtree

### step6. 06.mcmctree.sh

1. Calculate CV (coefficient of variance) value of root_to_tip_distances of block gene trees

`perl get_MSY_gene_tree.pl MSY.euchromatin.filtered.maf_blocks MSY.euchromatin.gene_trees.list`

`python calculate_tree_cv.py MSY.euchromatin.gene_trees.list MSY.euchromatin.gene_trees.CV_out`

2. Obtain the blocks with the lowest 20% CV values

`perl extract_block_fasta.pl All_samples.list CHM13_Y.class.bed Gene_tree.CV20.blocks.list Gene_tree.CV20.blocks.fasta Gene_tree.CV20.blocks.fasta.partition.list`

`seqret -sequence Gene_tree.CV20.blocks.fasta -outseq Gene_tree.CV20.blocks.nex -osformat nexus`

`perl partition_nex.pl Gene_tree.CV20.blocks.fasta Gene_tree.CV20.blocks.fasta.partition.list 03_CV20`

3. Run mcmctree

`mcmctree 01_CV20_step1.ctl`

`ln -s ../step1/out.BV in.BV`

`mcmctree 01_CV20_step2.ctl`



