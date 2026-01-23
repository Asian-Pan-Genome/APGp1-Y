### Running syri software to detect large inversions
#### For 160 APGp1 individuals:
```
./nucmer_syri.sh CHM13 KOR04
# 'CHM13' represents the reference id (HG002-Y), and 'KOR04' represent the sample id.
```
#### For scaffold-level assemblies of '43Ys' individuals:
```
./01_ragtag.sh CHM13 HG00512
./02_syri.sh CHM13 HG00512
```
#### Generate synteny plot using plotsr, e.g.,
```
plotsr --sr C013-CHA-E13syri.out --genomes C013-CHA-E13.genomes.txt -H 3 -W 5 -o C013-CHA-E13.syri.pdf
```
### Running PAV software for validation
```
singularity run --bind "$(pwd):$(pwd)" pav_latest.sif -c 12
# 'pav_latest.sif' was from https://github.com/EichlerLab/pav
```
