##### 1. extracting sequence of gap-adjacent regions (+/- 1Kb) for each sample using bedtools
##### 2. align these gap-sequences to CHM13-Y using minimap2
##### 3. find the affected variants by assembly gaps
```
perl find_gap_affected_variants.pl All_APG.assembly.gaps /share/home/zhanglab/user/liujing/LiuJing/03_pangenome/43Ys/Gaps ../204YSample.CHM13_MC.filter.SV.vcf SV.Gaps.out
```
