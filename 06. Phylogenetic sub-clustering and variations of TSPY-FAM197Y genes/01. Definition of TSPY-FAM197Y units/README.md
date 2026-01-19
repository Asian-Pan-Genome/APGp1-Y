### Extract the fasta of TSPY2-FAM197Y unit for HG002-Y

`perl get_region_fa.pl HG002.chrY.fa 10206927 10227249 HG002.TSPY2-FAM197Y.unit.fa`

### Define all the TSPY-FAM197Y units of HG002-Y, as well as all other individuals

`minimap2 -cx asm10 -t8 --cs HG002.chrY.fa HG002.TSPY2-FAM197Y.unit.fa > HG002.TSPY_FAM197Y.block.paf`

`perl extract_block.pl HG002.chrY.fa HG002.TSPY_FAM197Y.block.paf HG002.TSPY_FAM197Y.all_blocks.fa`
