#02 Subregion Annotation

**Generate chain files using nf-LO:**
```bash
  nextflow run nf-LO-1.8.0 \
    --source CHM13.chrY.fa \
    --target sample.chrY.fasta \
    --outdir sample_dir \
    -profile conda --aligner minimap2
  rm -r work
```
**process chain file with CHM13:**
```bash
python ~/Software/chaintools-0.1/src/split.py -c sample_dir/liftover.chain -o sample.CHM13.split.chain
python ~/Software/chaintools-0.1/src/to_paf.py -c sample.CHM13.split.chain  -t CHM13.chrY.fa -q sample.chrY.fasta -o sample.CHM13.split.paf
cat sample.CHM13.split.paf | rb break-paf --max-size 10000  | rb trim-paf -r | rb invert | rb trim-paf -r | rb invert > sample.CHM13.out.paf
~/Software/paf2chain/paf2chain -i sample.CHM13.out.paf > sample.CHM13.out.chain
rm sample.CHM13.chain sample.CHM13.split.chain sample.CHM13.split.paf
```
**Liftover CHM13 class annotation to sample:**
```bash
CrossMap.py bed sample.CHM13.out.chain CHM13.Y.class.bed > sample.chrY.sub_region.bed.CHM13_crossmap
grep -v Unmap sample.chrY.sub_region.bed.CHM13_crossmap > sample.chrY.sub_region.bed.CHM13_crossmap.filter
rm sample.chrY.sub_region.bed.CHM13_crossmap
perl crossmap_region_merge.pl sample.chrY.sub_region.bed.CHM13_crossmap.filter sample.chrY.sub_region.bed.CHM13_based.anno
#then manually trim the sample.chrY.sub_region.bed.CHM13_based.anno
```
