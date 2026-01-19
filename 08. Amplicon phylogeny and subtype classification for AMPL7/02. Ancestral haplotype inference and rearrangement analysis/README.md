### Ancestral haplotype reconstruction of AMPL7
#### Convert each haplotype into number-ordered pseudo-chromosome. Each number represents one amplicon subgroup. The numbers represent: 1: b1; 2: b2; 3: g1; 4: r1; 5: r2; 6: gy1; 7: b3; 8: g2; 9: r3; 10: r4; 11: g3; 12: b4; 13: gy2. The '-' represent the reverse strand.

`perl simulate_genomic_fragment.pl 175_samples.AMPL7.amplicon_order.list 175_samples.AMPL7.amplicon_order.genomic_blocks.list`

#### Reconstruct the ancestral gene (amplicon) order, namely haplotype for each ancestral node on the Y-haplogroup tree. For example, the CT node:

`python /share/home/zhanglab/user/liujing/Software/anges_1.01/src/MASTER/anges_CAR.py CT.paramater.txt`

The inputs are genomic_blocks.list and AMPL7.nwk, which is derived from the concatenated maximum likelihood tree. The output was used for reference to infer the ancestral haplotype.

### Rearrangement inference of each haplotype against the ancestral haplotype of CT node (Hap6).
#### As current DCJ-based frameworks do not explicitly model duplications or gene conversion events, each haplotype was first reverted to a pre-duplication and pre-conversion state prior to DCJ analysis (Manually convert 175_haps.amplicon_order.info into 175_hap.amplicon_order.without_con_dup)
```
java -jar UniMoG-java11.jar -m=6 -d 175_hap.amplicon_order.without_con_dup > 175_hap.amplicon_order.UniMoG_out
sed -n '184,359p' 175_hap.amplicon_order.UniMoG_out > 175_hap.amplicon_order.UniMoG_out.phy
#refine 175_hap.amplicon_order.UniMoG_out.phy
perl convert.pl 175_hap.amplicon_order.UniMoG_out.phy 175_hap.amplicon_order.UniMoG_out.convert.phy
sed -i 's/\_/\-/g' 175_hap.amplicon_order.UniMoG_out.convert.phy
#Add the events of duplication and gene conversion
perl add_dis_of_con_dup.pl 175_hap.amplicon_order.UniMoG_out.convert.phy samples.con_dup.record.info 175_hap.amplicon_order.UniMoG_out.convert.add_con_dup.phy
```
### Haplotype network based on rearrangements compared to reference (Hap6).
```
perl convert_amplicon_order_to_vcf.pl 175_haps.amplicon_order.info All_rearrangement.pseudo_mutation.info 175_haps.amplicon_order.mutation.vcf
perl prepare_hap_info.pl 175_haps.amplicon_order.info All_rearrangement.pseudo_mutation.info 175_haps.statistic.info 175_haps.amplicon_order.pseudo_seq
```
#### Construct network using local PopART software with 175_haps.amplicon_order.pseudo_seq.
