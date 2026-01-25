## Sequence divergence analysis for DYZ repeats

**divwithcons:** This script calculates the mismatch-based divergence metrics
```bash
#put cons_squence as first read in sample.cons.DYZ1.fa | do not alignment
python getdiv.py 0 sample.cons.DYZ1.fa sample.cons.DYZ1.div
python getdiv.py 0 sample.cons.DYZ2.fa sample.cons.DYZ2.div
```
**plot with div:** Generate divergence plots using the output files from the previous step.
```bash
#C001-CHA-E01.DYZ1.div.bed and C001-CHA-E01.DYZ2.div.bed as the input for example in the same dir
python plot_divwithcons.py
```
