#!/bin/bash

#SBATCH --job-name=Gaps
#SBATCH --partition=cpu64
#SBATCH --cpus-per-task=4
#SBATCH --mem=5G
#SBATCH --output=Gaps.o
#SBATCH --error=Gaps.e

bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C003-CHA-E03.chrY.freeze.fa -bed C003-CHA-E03.gaps.bed -fo C003-CHA-E03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C003-CHA-E03.gaps.fa > C003-CHA-E03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C005-CHA-E05.chrY.freeze.fa -bed C005-CHA-E05.gaps.bed -fo C005-CHA-E05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C005-CHA-E05.gaps.fa > C005-CHA-E05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C005-CHA-E05.chrY.freeze.fa -bed C005-CHA-E05.gaps.bed -fo C005-CHA-E05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C005-CHA-E05.gaps.fa > C005-CHA-E05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C005-CHA-E05.chrY.freeze.fa -bed C005-CHA-E05.gaps.bed -fo C005-CHA-E05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C005-CHA-E05.gaps.fa > C005-CHA-E05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C006-CHA-E06.chrY.freeze.fa -bed C006-CHA-E06.gaps.bed -fo C006-CHA-E06.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C006-CHA-E06.gaps.fa > C006-CHA-E06.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C006-CHA-E06.chrY.freeze.fa -bed C006-CHA-E06.gaps.bed -fo C006-CHA-E06.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C006-CHA-E06.gaps.fa > C006-CHA-E06.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C006-CHA-E06.chrY.freeze.fa -bed C006-CHA-E06.gaps.bed -fo C006-CHA-E06.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C006-CHA-E06.gaps.fa > C006-CHA-E06.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C006-CHA-E06.chrY.freeze.fa -bed C006-CHA-E06.gaps.bed -fo C006-CHA-E06.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C006-CHA-E06.gaps.fa > C006-CHA-E06.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C006-CHA-E06.chrY.freeze.fa -bed C006-CHA-E06.gaps.bed -fo C006-CHA-E06.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C006-CHA-E06.gaps.fa > C006-CHA-E06.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C007-CHA-E07.chrY.freeze.fa -bed C007-CHA-E07.gaps.bed -fo C007-CHA-E07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C007-CHA-E07.gaps.fa > C007-CHA-E07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C007-CHA-E07.chrY.freeze.fa -bed C007-CHA-E07.gaps.bed -fo C007-CHA-E07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C007-CHA-E07.gaps.fa > C007-CHA-E07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C007-CHA-E07.chrY.freeze.fa -bed C007-CHA-E07.gaps.bed -fo C007-CHA-E07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C007-CHA-E07.gaps.fa > C007-CHA-E07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C007-CHA-E07.chrY.freeze.fa -bed C007-CHA-E07.gaps.bed -fo C007-CHA-E07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C007-CHA-E07.gaps.fa > C007-CHA-E07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C007-CHA-E07.chrY.freeze.fa -bed C007-CHA-E07.gaps.bed -fo C007-CHA-E07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C007-CHA-E07.gaps.fa > C007-CHA-E07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C007-CHA-E07.chrY.freeze.fa -bed C007-CHA-E07.gaps.bed -fo C007-CHA-E07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C007-CHA-E07.gaps.fa > C007-CHA-E07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C007-CHA-E07.chrY.freeze.fa -bed C007-CHA-E07.gaps.bed -fo C007-CHA-E07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C007-CHA-E07.gaps.fa > C007-CHA-E07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C007-CHA-E07.chrY.freeze.fa -bed C007-CHA-E07.gaps.bed -fo C007-CHA-E07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C007-CHA-E07.gaps.fa > C007-CHA-E07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C007-CHA-E07.chrY.freeze.fa -bed C007-CHA-E07.gaps.bed -fo C007-CHA-E07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C007-CHA-E07.gaps.fa > C007-CHA-E07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C007-CHA-E07.chrY.freeze.fa -bed C007-CHA-E07.gaps.bed -fo C007-CHA-E07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C007-CHA-E07.gaps.fa > C007-CHA-E07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C009-CHA-E09.chrY.freeze.fa -bed C009-CHA-E09.gaps.bed -fo C009-CHA-E09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C009-CHA-E09.gaps.fa > C009-CHA-E09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C009-CHA-E09.chrY.freeze.fa -bed C009-CHA-E09.gaps.bed -fo C009-CHA-E09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C009-CHA-E09.gaps.fa > C009-CHA-E09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C009-CHA-E09.chrY.freeze.fa -bed C009-CHA-E09.gaps.bed -fo C009-CHA-E09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C009-CHA-E09.gaps.fa > C009-CHA-E09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C009-CHA-E09.chrY.freeze.fa -bed C009-CHA-E09.gaps.bed -fo C009-CHA-E09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C009-CHA-E09.gaps.fa > C009-CHA-E09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C009-CHA-E09.chrY.freeze.fa -bed C009-CHA-E09.gaps.bed -fo C009-CHA-E09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C009-CHA-E09.gaps.fa > C009-CHA-E09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C010-CHA-E10.chrY.freeze.fa -bed C010-CHA-E10.gaps.bed -fo C010-CHA-E10.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C010-CHA-E10.gaps.fa > C010-CHA-E10.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C010-CHA-E10.chrY.freeze.fa -bed C010-CHA-E10.gaps.bed -fo C010-CHA-E10.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C010-CHA-E10.gaps.fa > C010-CHA-E10.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C011-CHA-E11.chrY.freeze.fa -bed C011-CHA-E11.gaps.bed -fo C011-CHA-E11.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C011-CHA-E11.gaps.fa > C011-CHA-E11.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C012-CHA-E12.chrY.freeze.fa -bed C012-CHA-E12.gaps.bed -fo C012-CHA-E12.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C012-CHA-E12.gaps.fa > C012-CHA-E12.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C012-CHA-E12.chrY.freeze.fa -bed C012-CHA-E12.gaps.bed -fo C012-CHA-E12.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C012-CHA-E12.gaps.fa > C012-CHA-E12.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C013-CHA-E13.chrY.freeze.fa -bed C013-CHA-E13.gaps.bed -fo C013-CHA-E13.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C013-CHA-E13.gaps.fa > C013-CHA-E13.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C013-CHA-E13.chrY.freeze.fa -bed C013-CHA-E13.gaps.bed -fo C013-CHA-E13.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C013-CHA-E13.gaps.fa > C013-CHA-E13.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C013-CHA-E13.chrY.freeze.fa -bed C013-CHA-E13.gaps.bed -fo C013-CHA-E13.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C013-CHA-E13.gaps.fa > C013-CHA-E13.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C013-CHA-E13.chrY.freeze.fa -bed C013-CHA-E13.gaps.bed -fo C013-CHA-E13.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C013-CHA-E13.gaps.fa > C013-CHA-E13.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C013-CHA-E13.chrY.freeze.fa -bed C013-CHA-E13.gaps.bed -fo C013-CHA-E13.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C013-CHA-E13.gaps.fa > C013-CHA-E13.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C013-CHA-E13.chrY.freeze.fa -bed C013-CHA-E13.gaps.bed -fo C013-CHA-E13.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C013-CHA-E13.gaps.fa > C013-CHA-E13.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C015-CHA-E15.chrY.freeze.fa -bed C015-CHA-E15.gaps.bed -fo C015-CHA-E15.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C015-CHA-E15.gaps.fa > C015-CHA-E15.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C015-CHA-E15.chrY.freeze.fa -bed C015-CHA-E15.gaps.bed -fo C015-CHA-E15.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C015-CHA-E15.gaps.fa > C015-CHA-E15.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C015-CHA-E15.chrY.freeze.fa -bed C015-CHA-E15.gaps.bed -fo C015-CHA-E15.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C015-CHA-E15.gaps.fa > C015-CHA-E15.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C015-CHA-E15.chrY.freeze.fa -bed C015-CHA-E15.gaps.bed -fo C015-CHA-E15.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C015-CHA-E15.gaps.fa > C015-CHA-E15.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C018-CHA-E18.chrY.freeze.fa -bed C018-CHA-E18.gaps.bed -fo C018-CHA-E18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C018-CHA-E18.gaps.fa > C018-CHA-E18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C018-CHA-E18.chrY.freeze.fa -bed C018-CHA-E18.gaps.bed -fo C018-CHA-E18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C018-CHA-E18.gaps.fa > C018-CHA-E18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C018-CHA-E18.chrY.freeze.fa -bed C018-CHA-E18.gaps.bed -fo C018-CHA-E18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C018-CHA-E18.gaps.fa > C018-CHA-E18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C018-CHA-E18.chrY.freeze.fa -bed C018-CHA-E18.gaps.bed -fo C018-CHA-E18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C018-CHA-E18.gaps.fa > C018-CHA-E18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C018-CHA-E18.chrY.freeze.fa -bed C018-CHA-E18.gaps.bed -fo C018-CHA-E18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C018-CHA-E18.gaps.fa > C018-CHA-E18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C018-CHA-E18.chrY.freeze.fa -bed C018-CHA-E18.gaps.bed -fo C018-CHA-E18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C018-CHA-E18.gaps.fa > C018-CHA-E18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C020-CHA-E20.chrY.freeze.fa -bed C020-CHA-E20.gaps.bed -fo C020-CHA-E20.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C020-CHA-E20.gaps.fa > C020-CHA-E20.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C022-CHA-S02_2.chrY.freeze.fa -bed C022-CHA-S02_2.gaps.bed -fo C022-CHA-S02_2.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C022-CHA-S02_2.gaps.fa > C022-CHA-S02_2.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C022-CHA-S02.chrY.freeze.fa -bed C022-CHA-S02.gaps.bed -fo C022-CHA-S02.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C022-CHA-S02.gaps.fa > C022-CHA-S02.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C023-CHA-S03.chrY.freeze.fa -bed C023-CHA-S03.gaps.bed -fo C023-CHA-S03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C023-CHA-S03.gaps.fa > C023-CHA-S03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C023-CHA-S03.chrY.freeze.fa -bed C023-CHA-S03.gaps.bed -fo C023-CHA-S03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C023-CHA-S03.gaps.fa > C023-CHA-S03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C023-CHA-S03.chrY.freeze.fa -bed C023-CHA-S03.gaps.bed -fo C023-CHA-S03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C023-CHA-S03.gaps.fa > C023-CHA-S03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C024-CHA-S04_2.chrY.freeze.fa -bed C024-CHA-S04_2.gaps.bed -fo C024-CHA-S04_2.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C024-CHA-S04_2.gaps.fa > C024-CHA-S04_2.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C024-CHA-S04_2.chrY.freeze.fa -bed C024-CHA-S04_2.gaps.bed -fo C024-CHA-S04_2.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C024-CHA-S04_2.gaps.fa > C024-CHA-S04_2.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C027-CHA-S07.chrY.freeze.fa -bed C027-CHA-S07.gaps.bed -fo C027-CHA-S07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C027-CHA-S07.gaps.fa > C027-CHA-S07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C028-CHA-S08.chrY.freeze.fa -bed C028-CHA-S08.gaps.bed -fo C028-CHA-S08.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C028-CHA-S08.gaps.fa > C028-CHA-S08.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C028-CHA-S08.chrY.freeze.fa -bed C028-CHA-S08.gaps.bed -fo C028-CHA-S08.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C028-CHA-S08.gaps.fa > C028-CHA-S08.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C028-CHA-S08.chrY.freeze.fa -bed C028-CHA-S08.gaps.bed -fo C028-CHA-S08.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C028-CHA-S08.gaps.fa > C028-CHA-S08.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C035-CHA-S15.chrY.freeze.fa -bed C035-CHA-S15.gaps.bed -fo C035-CHA-S15.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C035-CHA-S15.gaps.fa > C035-CHA-S15.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C035-CHA-S15.chrY.freeze.fa -bed C035-CHA-S15.gaps.bed -fo C035-CHA-S15.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C035-CHA-S15.gaps.fa > C035-CHA-S15.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C035-CHA-S15.chrY.freeze.fa -bed C035-CHA-S15.gaps.bed -fo C035-CHA-S15.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C035-CHA-S15.gaps.fa > C035-CHA-S15.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C035-CHA-S15.chrY.freeze.fa -bed C035-CHA-S15.gaps.bed -fo C035-CHA-S15.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C035-CHA-S15.gaps.fa > C035-CHA-S15.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C035-CHA-S15.chrY.freeze.fa -bed C035-CHA-S15.gaps.bed -fo C035-CHA-S15.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C035-CHA-S15.gaps.fa > C035-CHA-S15.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C038-CHA-S18.chrY.freeze.fa -bed C038-CHA-S18.gaps.bed -fo C038-CHA-S18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C038-CHA-S18.gaps.fa > C038-CHA-S18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C039-CHA-S19.chrY.freeze.fa -bed C039-CHA-S19.gaps.bed -fo C039-CHA-S19.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C039-CHA-S19.gaps.fa > C039-CHA-S19.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C041-CHA-N01.chrY.freeze.fa -bed C041-CHA-N01.gaps.bed -fo C041-CHA-N01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C041-CHA-N01.gaps.fa > C041-CHA-N01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C049-CHA-N09.chrY.freeze.fa -bed C049-CHA-N09.gaps.bed -fo C049-CHA-N09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C049-CHA-N09.gaps.fa > C049-CHA-N09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C049-CHA-N09.chrY.freeze.fa -bed C049-CHA-N09.gaps.bed -fo C049-CHA-N09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C049-CHA-N09.gaps.fa > C049-CHA-N09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C049-CHA-N09.chrY.freeze.fa -bed C049-CHA-N09.gaps.bed -fo C049-CHA-N09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C049-CHA-N09.gaps.fa > C049-CHA-N09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C049-CHA-N09.chrY.freeze.fa -bed C049-CHA-N09.gaps.bed -fo C049-CHA-N09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C049-CHA-N09.gaps.fa > C049-CHA-N09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C049-CHA-N09.chrY.freeze.fa -bed C049-CHA-N09.gaps.bed -fo C049-CHA-N09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C049-CHA-N09.gaps.fa > C049-CHA-N09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C049-CHA-N09.chrY.freeze.fa -bed C049-CHA-N09.gaps.bed -fo C049-CHA-N09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C049-CHA-N09.gaps.fa > C049-CHA-N09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C049-CHA-N09.chrY.freeze.fa -bed C049-CHA-N09.gaps.bed -fo C049-CHA-N09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C049-CHA-N09.gaps.fa > C049-CHA-N09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C049-CHA-N09.chrY.freeze.fa -bed C049-CHA-N09.gaps.bed -fo C049-CHA-N09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C049-CHA-N09.gaps.fa > C049-CHA-N09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C050-CHA-N10.chrY.freeze.fa -bed C050-CHA-N10.gaps.bed -fo C050-CHA-N10.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C050-CHA-N10.gaps.fa > C050-CHA-N10.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C050-CHA-N10.chrY.freeze.fa -bed C050-CHA-N10.gaps.bed -fo C050-CHA-N10.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C050-CHA-N10.gaps.fa > C050-CHA-N10.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C050-CHA-N10.chrY.freeze.fa -bed C050-CHA-N10.gaps.bed -fo C050-CHA-N10.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C050-CHA-N10.gaps.fa > C050-CHA-N10.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C050-CHA-N10.chrY.freeze.fa -bed C050-CHA-N10.gaps.bed -fo C050-CHA-N10.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C050-CHA-N10.gaps.fa > C050-CHA-N10.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C050-CHA-N10.chrY.freeze.fa -bed C050-CHA-N10.gaps.bed -fo C050-CHA-N10.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C050-CHA-N10.gaps.fa > C050-CHA-N10.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C052-CHA-N12.chrY.freeze.fa -bed C052-CHA-N12.gaps.bed -fo C052-CHA-N12.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C052-CHA-N12.gaps.fa > C052-CHA-N12.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C054-CHA-N14.chrY.freeze.fa -bed C054-CHA-N14.gaps.bed -fo C054-CHA-N14.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C054-CHA-N14.gaps.fa > C054-CHA-N14.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C055-CHA-N15.chrY.freeze.fa -bed C055-CHA-N15.gaps.bed -fo C055-CHA-N15.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C055-CHA-N15.gaps.fa > C055-CHA-N15.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C056-CHA-N16.chrY.freeze.fa -bed C056-CHA-N16.gaps.bed -fo C056-CHA-N16.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C056-CHA-N16.gaps.fa > C056-CHA-N16.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C056-CHA-N16.chrY.freeze.fa -bed C056-CHA-N16.gaps.bed -fo C056-CHA-N16.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C056-CHA-N16.gaps.fa > C056-CHA-N16.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C058-CHA-N18.chrY.freeze.fa -bed C058-CHA-N18.gaps.bed -fo C058-CHA-N18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C058-CHA-N18.gaps.fa > C058-CHA-N18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C060-CHA-N20.chrY.freeze.fa -bed C060-CHA-N20.gaps.bed -fo C060-CHA-N20.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C060-CHA-N20.gaps.fa > C060-CHA-N20.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C060-CHA-N20.chrY.freeze.fa -bed C060-CHA-N20.gaps.bed -fo C060-CHA-N20.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C060-CHA-N20.gaps.fa > C060-CHA-N20.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C064-CHA-NE04.chrY.freeze.fa -bed C064-CHA-NE04.gaps.bed -fo C064-CHA-NE04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C064-CHA-NE04.gaps.fa > C064-CHA-NE04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C073-CHA-NE13.chrY.freeze.fa -bed C073-CHA-NE13.gaps.bed -fo C073-CHA-NE13.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C073-CHA-NE13.gaps.fa > C073-CHA-NE13.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C077-CHA-NE17.chrY.freeze.fa -bed C077-CHA-NE17.gaps.bed -fo C077-CHA-NE17.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C077-CHA-NE17.gaps.fa > C077-CHA-NE17.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C077-CHA-NE17.chrY.freeze.fa -bed C077-CHA-NE17.gaps.bed -fo C077-CHA-NE17.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C077-CHA-NE17.gaps.fa > C077-CHA-NE17.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C077-CHA-NE17.chrY.freeze.fa -bed C077-CHA-NE17.gaps.bed -fo C077-CHA-NE17.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C077-CHA-NE17.gaps.fa > C077-CHA-NE17.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C077-CHA-NE17.chrY.freeze.fa -bed C077-CHA-NE17.gaps.bed -fo C077-CHA-NE17.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C077-CHA-NE17.gaps.fa > C077-CHA-NE17.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C077-CHA-NE17.chrY.freeze.fa -bed C077-CHA-NE17.gaps.bed -fo C077-CHA-NE17.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C077-CHA-NE17.gaps.fa > C077-CHA-NE17.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C078-CHA-NE18.chrY.freeze.fa -bed C078-CHA-NE18.gaps.bed -fo C078-CHA-NE18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C078-CHA-NE18.gaps.fa > C078-CHA-NE18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C078-CHA-NE18.chrY.freeze.fa -bed C078-CHA-NE18.gaps.bed -fo C078-CHA-NE18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C078-CHA-NE18.gaps.fa > C078-CHA-NE18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C078-CHA-NE18.chrY.freeze.fa -bed C078-CHA-NE18.gaps.bed -fo C078-CHA-NE18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C078-CHA-NE18.gaps.fa > C078-CHA-NE18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C078-CHA-NE18.chrY.freeze.fa -bed C078-CHA-NE18.gaps.bed -fo C078-CHA-NE18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C078-CHA-NE18.gaps.fa > C078-CHA-NE18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C078-CHA-NE18.chrY.freeze.fa -bed C078-CHA-NE18.gaps.bed -fo C078-CHA-NE18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C078-CHA-NE18.gaps.fa > C078-CHA-NE18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C079-CHA-NE19.chrY.freeze.fa -bed C079-CHA-NE19.gaps.bed -fo C079-CHA-NE19.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C079-CHA-NE19.gaps.fa > C079-CHA-NE19.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C079-CHA-NE19.chrY.freeze.fa -bed C079-CHA-NE19.gaps.bed -fo C079-CHA-NE19.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C079-CHA-NE19.gaps.fa > C079-CHA-NE19.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C079-CHA-NE19.chrY.freeze.fa -bed C079-CHA-NE19.gaps.bed -fo C079-CHA-NE19.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C079-CHA-NE19.gaps.fa > C079-CHA-NE19.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C079-CHA-NE19.chrY.freeze.fa -bed C079-CHA-NE19.gaps.bed -fo C079-CHA-NE19.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C079-CHA-NE19.gaps.fa > C079-CHA-NE19.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C079-CHA-NE19.chrY.freeze.fa -bed C079-CHA-NE19.gaps.bed -fo C079-CHA-NE19.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C079-CHA-NE19.gaps.fa > C079-CHA-NE19.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C079-CHA-NE19.chrY.freeze.fa -bed C079-CHA-NE19.gaps.bed -fo C079-CHA-NE19.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C079-CHA-NE19.gaps.fa > C079-CHA-NE19.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C079-CHA-NE19.chrY.freeze.fa -bed C079-CHA-NE19.gaps.bed -fo C079-CHA-NE19.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C079-CHA-NE19.gaps.fa > C079-CHA-NE19.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C079-CHA-NE19.chrY.freeze.fa -bed C079-CHA-NE19.gaps.bed -fo C079-CHA-NE19.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C079-CHA-NE19.gaps.fa > C079-CHA-NE19.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C079-CHA-NE19.chrY.freeze.fa -bed C079-CHA-NE19.gaps.bed -fo C079-CHA-NE19.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C079-CHA-NE19.gaps.fa > C079-CHA-NE19.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C081-CHA-C01.chrY.freeze.fa -bed C081-CHA-C01.gaps.bed -fo C081-CHA-C01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C081-CHA-C01.gaps.fa > C081-CHA-C01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C081-CHA-C01.chrY.freeze.fa -bed C081-CHA-C01.gaps.bed -fo C081-CHA-C01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C081-CHA-C01.gaps.fa > C081-CHA-C01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C081-CHA-C01.chrY.freeze.fa -bed C081-CHA-C01.gaps.bed -fo C081-CHA-C01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C081-CHA-C01.gaps.fa > C081-CHA-C01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C082-CHA-C02.chrY.freeze.fa -bed C082-CHA-C02.gaps.bed -fo C082-CHA-C02.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C082-CHA-C02.gaps.fa > C082-CHA-C02.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C084-CHA-C04.chrY.freeze.fa -bed C084-CHA-C04.gaps.bed -fo C084-CHA-C04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C084-CHA-C04.gaps.fa > C084-CHA-C04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C084-CHA-C04.chrY.freeze.fa -bed C084-CHA-C04.gaps.bed -fo C084-CHA-C04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C084-CHA-C04.gaps.fa > C084-CHA-C04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C084-CHA-C04.chrY.freeze.fa -bed C084-CHA-C04.gaps.bed -fo C084-CHA-C04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C084-CHA-C04.gaps.fa > C084-CHA-C04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C084-CHA-C04.chrY.freeze.fa -bed C084-CHA-C04.gaps.bed -fo C084-CHA-C04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C084-CHA-C04.gaps.fa > C084-CHA-C04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C084-CHA-C04.chrY.freeze.fa -bed C084-CHA-C04.gaps.bed -fo C084-CHA-C04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C084-CHA-C04.gaps.fa > C084-CHA-C04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C085-CHA-C05.chrY.freeze.fa -bed C085-CHA-C05.gaps.bed -fo C085-CHA-C05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C085-CHA-C05.gaps.fa > C085-CHA-C05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C086-CHA-C06.chrY.freeze.fa -bed C086-CHA-C06.gaps.bed -fo C086-CHA-C06.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C086-CHA-C06.gaps.fa > C086-CHA-C06.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C086-CHA-C06.chrY.freeze.fa -bed C086-CHA-C06.gaps.bed -fo C086-CHA-C06.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C086-CHA-C06.gaps.fa > C086-CHA-C06.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C086-CHA-C06.chrY.freeze.fa -bed C086-CHA-C06.gaps.bed -fo C086-CHA-C06.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C086-CHA-C06.gaps.fa > C086-CHA-C06.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C086-CHA-C06.chrY.freeze.fa -bed C086-CHA-C06.gaps.bed -fo C086-CHA-C06.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C086-CHA-C06.gaps.fa > C086-CHA-C06.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C087-CHA-C07.chrY.freeze.fa -bed C087-CHA-C07.gaps.bed -fo C087-CHA-C07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C087-CHA-C07.gaps.fa > C087-CHA-C07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C087-CHA-C07.chrY.freeze.fa -bed C087-CHA-C07.gaps.bed -fo C087-CHA-C07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C087-CHA-C07.gaps.fa > C087-CHA-C07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C087-CHA-C07.chrY.freeze.fa -bed C087-CHA-C07.gaps.bed -fo C087-CHA-C07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C087-CHA-C07.gaps.fa > C087-CHA-C07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C087-CHA-C07.chrY.freeze.fa -bed C087-CHA-C07.gaps.bed -fo C087-CHA-C07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C087-CHA-C07.gaps.fa > C087-CHA-C07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C087-CHA-C07.chrY.freeze.fa -bed C087-CHA-C07.gaps.bed -fo C087-CHA-C07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C087-CHA-C07.gaps.fa > C087-CHA-C07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C087-CHA-C07.chrY.freeze.fa -bed C087-CHA-C07.gaps.bed -fo C087-CHA-C07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C087-CHA-C07.gaps.fa > C087-CHA-C07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C088-CHA-C08.chrY.freeze.fa -bed C088-CHA-C08.gaps.bed -fo C088-CHA-C08.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C088-CHA-C08.gaps.fa > C088-CHA-C08.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C088-CHA-C08.chrY.freeze.fa -bed C088-CHA-C08.gaps.bed -fo C088-CHA-C08.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C088-CHA-C08.gaps.fa > C088-CHA-C08.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C088-CHA-C08.chrY.freeze.fa -bed C088-CHA-C08.gaps.bed -fo C088-CHA-C08.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C088-CHA-C08.gaps.fa > C088-CHA-C08.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C089-CHA-C09.chrY.freeze.fa -bed C089-CHA-C09.gaps.bed -fo C089-CHA-C09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C089-CHA-C09.gaps.fa > C089-CHA-C09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C089-CHA-C09.chrY.freeze.fa -bed C089-CHA-C09.gaps.bed -fo C089-CHA-C09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C089-CHA-C09.gaps.fa > C089-CHA-C09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C089-CHA-C09.chrY.freeze.fa -bed C089-CHA-C09.gaps.bed -fo C089-CHA-C09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C089-CHA-C09.gaps.fa > C089-CHA-C09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C089-CHA-C09.chrY.freeze.fa -bed C089-CHA-C09.gaps.bed -fo C089-CHA-C09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C089-CHA-C09.gaps.fa > C089-CHA-C09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C089-CHA-C09.chrY.freeze.fa -bed C089-CHA-C09.gaps.bed -fo C089-CHA-C09.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C089-CHA-C09.gaps.fa > C089-CHA-C09.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C090-CHA-C10.chrY.freeze.fa -bed C090-CHA-C10.gaps.bed -fo C090-CHA-C10.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C090-CHA-C10.gaps.fa > C090-CHA-C10.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C090-CHA-C10.chrY.freeze.fa -bed C090-CHA-C10.gaps.bed -fo C090-CHA-C10.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C090-CHA-C10.gaps.fa > C090-CHA-C10.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C090-CHA-C10.chrY.freeze.fa -bed C090-CHA-C10.gaps.bed -fo C090-CHA-C10.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C090-CHA-C10.gaps.fa > C090-CHA-C10.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C092-CHA-C12.chrY.freeze.fa -bed C092-CHA-C12.gaps.bed -fo C092-CHA-C12.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C092-CHA-C12.gaps.fa > C092-CHA-C12.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C092-CHA-C12.chrY.freeze.fa -bed C092-CHA-C12.gaps.bed -fo C092-CHA-C12.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C092-CHA-C12.gaps.fa > C092-CHA-C12.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C092-CHA-C12.chrY.freeze.fa -bed C092-CHA-C12.gaps.bed -fo C092-CHA-C12.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C092-CHA-C12.gaps.fa > C092-CHA-C12.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C094-CHA-C14.chrY.freeze.fa -bed C094-CHA-C14.gaps.bed -fo C094-CHA-C14.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C094-CHA-C14.gaps.fa > C094-CHA-C14.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C097-CHA-C17.chrY.freeze.fa -bed C097-CHA-C17.gaps.bed -fo C097-CHA-C17.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C097-CHA-C17.gaps.fa > C097-CHA-C17.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C097-CHA-C17.chrY.freeze.fa -bed C097-CHA-C17.gaps.bed -fo C097-CHA-C17.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C097-CHA-C17.gaps.fa > C097-CHA-C17.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C098-CHA-C18.chrY.freeze.fa -bed C098-CHA-C18.gaps.bed -fo C098-CHA-C18.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C098-CHA-C18.gaps.fa > C098-CHA-C18.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C101-CZA01.chrY.freeze.fa -bed C101-CZA01.gaps.bed -fo C101-CZA01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C101-CZA01.gaps.fa > C101-CZA01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C103-CZA03.chrY.freeze.fa -bed C103-CZA03.gaps.bed -fo C103-CZA03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C103-CZA03.gaps.fa > C103-CZA03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C103-CZA03.chrY.freeze.fa -bed C103-CZA03.gaps.bed -fo C103-CZA03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C103-CZA03.gaps.fa > C103-CZA03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C103-CZA03.chrY.freeze.fa -bed C103-CZA03.gaps.bed -fo C103-CZA03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C103-CZA03.gaps.fa > C103-CZA03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C104-CZA04.chrY.freeze.fa -bed C104-CZA04.gaps.bed -fo C104-CZA04.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C104-CZA04.gaps.fa > C104-CZA04.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C107-CZA07.chrY.freeze.fa -bed C107-CZA07.gaps.bed -fo C107-CZA07.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C107-CZA07.gaps.fa > C107-CZA07.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C108-CZA08.chrY.freeze.fa -bed C108-CZA08.gaps.bed -fo C108-CZA08.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C108-CZA08.gaps.fa > C108-CZA08.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C108-CZA08.chrY.freeze.fa -bed C108-CZA08.gaps.bed -fo C108-CZA08.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C108-CZA08.gaps.fa > C108-CZA08.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C108-CZA08.chrY.freeze.fa -bed C108-CZA08.gaps.bed -fo C108-CZA08.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C108-CZA08.gaps.fa > C108-CZA08.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C109-CUG01.chrY.freeze.fa -bed C109-CUG01.gaps.bed -fo C109-CUG01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C109-CUG01.gaps.fa > C109-CUG01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C111-CUG03.chrY.freeze.fa -bed C111-CUG03.gaps.bed -fo C111-CUG03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C111-CUG03.gaps.fa > C111-CUG03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C113-CUG05.chrY.freeze.fa -bed C113-CUG05.gaps.bed -fo C113-CUG05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C113-CUG05.gaps.fa > C113-CUG05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C113-CUG05.chrY.freeze.fa -bed C113-CUG05.gaps.bed -fo C113-CUG05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C113-CUG05.gaps.fa > C113-CUG05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C113-CUG05.chrY.freeze.fa -bed C113-CUG05.gaps.bed -fo C113-CUG05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C113-CUG05.gaps.fa > C113-CUG05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C114-CMG01.chrY.freeze.fa -bed C114-CMG01.gaps.bed -fo C114-CMG01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C114-CMG01.gaps.fa > C114-CMG01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C115-CMG02.chrY.freeze.fa -bed C115-CMG02.gaps.bed -fo C115-CMG02.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C115-CMG02.gaps.fa > C115-CMG02.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C116-CMG03.chrY.freeze.fa -bed C116-CMG03.gaps.bed -fo C116-CMG03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C116-CMG03.gaps.fa > C116-CMG03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C116-CMG03.chrY.freeze.fa -bed C116-CMG03.gaps.bed -fo C116-CMG03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C116-CMG03.gaps.fa > C116-CMG03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C118-CMG05.chrY.freeze.fa -bed C118-CMG05.gaps.bed -fo C118-CMG05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C118-CMG05.gaps.fa > C118-CMG05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C118-CMG05.chrY.freeze.fa -bed C118-CMG05.gaps.bed -fo C118-CMG05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C118-CMG05.gaps.fa > C118-CMG05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C118-CMG05.chrY.freeze.fa -bed C118-CMG05.gaps.bed -fo C118-CMG05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C118-CMG05.gaps.fa > C118-CMG05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C118-CMG05.chrY.freeze.fa -bed C118-CMG05.gaps.bed -fo C118-CMG05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C118-CMG05.gaps.fa > C118-CMG05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C118-CMG05.chrY.freeze.fa -bed C118-CMG05.gaps.bed -fo C118-CMG05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C118-CMG05.gaps.fa > C118-CMG05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C119-CKZ01.chrY.freeze.fa -bed C119-CKZ01.gaps.bed -fo C119-CKZ01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C119-CKZ01.gaps.fa > C119-CKZ01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C119-CKZ01.chrY.freeze.fa -bed C119-CKZ01.gaps.bed -fo C119-CKZ01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C119-CKZ01.gaps.fa > C119-CKZ01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C123-CKZ05.chrY.freeze.fa -bed C123-CKZ05.gaps.bed -fo C123-CKZ05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C123-CKZ05.gaps.fa > C123-CKZ05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C124-CZH01.chrY.freeze.fa -bed C124-CZH01.gaps.bed -fo C124-CZH01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C124-CZH01.gaps.fa > C124-CZH01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C124-CZH01.chrY.freeze.fa -bed C124-CZH01.gaps.bed -fo C124-CZH01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C124-CZH01.gaps.fa > C124-CZH01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C124-CZH01.chrY.freeze.fa -bed C124-CZH01.gaps.bed -fo C124-CZH01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C124-CZH01.gaps.fa > C124-CZH01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C130-CYI02.chrY.freeze.fa -bed C130-CYI02.gaps.bed -fo C130-CYI02.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C130-CYI02.gaps.fa > C130-CYI02.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C142-CHU01.chrY.freeze.fa -bed C142-CHU01.gaps.bed -fo C142-CHU01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C142-CHU01.gaps.fa > C142-CHU01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C142-CHU01.chrY.freeze.fa -bed C142-CHU01.gaps.bed -fo C142-CHU01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C142-CHU01.gaps.fa > C142-CHU01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C144-CHU03.chrY.freeze.fa -bed C144-CHU03.gaps.bed -fo C144-CHU03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C144-CHU03.gaps.fa > C144-CHU03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C144-CHU03.chrY.freeze.fa -bed C144-CHU03.gaps.bed -fo C144-CHU03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C144-CHU03.gaps.fa > C144-CHU03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C144-CHU03.chrY.freeze.fa -bed C144-CHU03.gaps.bed -fo C144-CHU03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C144-CHU03.gaps.fa > C144-CHU03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C144-CHU03.chrY.freeze.fa -bed C144-CHU03.gaps.bed -fo C144-CHU03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C144-CHU03.gaps.fa > C144-CHU03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C144-CHU03.chrY.freeze.fa -bed C144-CHU03.gaps.bed -fo C144-CHU03.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C144-CHU03.gaps.fa > C144-CHU03.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C145-CMA01.chrY.freeze.fa -bed C145-CMA01.gaps.bed -fo C145-CMA01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C145-CMA01.gaps.fa > C145-CMA01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C145-CMA01.chrY.freeze.fa -bed C145-CMA01.gaps.bed -fo C145-CMA01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C145-CMA01.gaps.fa > C145-CMA01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C145-CMA01.chrY.freeze.fa -bed C145-CMA01.gaps.bed -fo C145-CMA01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C145-CMA01.gaps.fa > C145-CMA01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C145-CMA01.chrY.freeze.fa -bed C145-CMA01.gaps.bed -fo C145-CMA01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C145-CMA01.gaps.fa > C145-CMA01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C149-CTJ02.chrY.freeze.fa -bed C149-CTJ02.gaps.bed -fo C149-CTJ02.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C149-CTJ02.gaps.fa > C149-CTJ02.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C149-CTJ02.chrY.freeze.fa -bed C149-CTJ02.gaps.bed -fo C149-CTJ02.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C149-CTJ02.gaps.fa > C149-CTJ02.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C151-CHA-E21.chrY.freeze.fa -bed C151-CHA-E21.gaps.bed -fo C151-CHA-E21.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C151-CHA-E21.gaps.fa > C151-CHA-E21.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C151-CHA-E21.chrY.freeze.fa -bed C151-CHA-E21.gaps.bed -fo C151-CHA-E21.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C151-CHA-E21.gaps.fa > C151-CHA-E21.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C151-CHA-E21.chrY.freeze.fa -bed C151-CHA-E21.gaps.bed -fo C151-CHA-E21.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C151-CHA-E21.gaps.fa > C151-CHA-E21.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C151-CHA-E21.chrY.freeze.fa -bed C151-CHA-E21.gaps.bed -fo C151-CHA-E21.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C151-CHA-E21.gaps.fa > C151-CHA-E21.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C153-CHA-S21.chrY.freeze.fa -bed C153-CHA-S21.gaps.bed -fo C153-CHA-S21.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C153-CHA-S21.gaps.fa > C153-CHA-S21.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C153-CHA-S21.chrY.freeze.fa -bed C153-CHA-S21.gaps.bed -fo C153-CHA-S21.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C153-CHA-S21.gaps.fa > C153-CHA-S21.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C153-CHA-S21.chrY.freeze.fa -bed C153-CHA-S21.gaps.bed -fo C153-CHA-S21.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C153-CHA-S21.gaps.fa > C153-CHA-S21.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C153-CHA-S21.chrY.freeze.fa -bed C153-CHA-S21.gaps.bed -fo C153-CHA-S21.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C153-CHA-S21.gaps.fa > C153-CHA-S21.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C153-CHA-S21.chrY.freeze.fa -bed C153-CHA-S21.gaps.bed -fo C153-CHA-S21.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C153-CHA-S21.gaps.fa > C153-CHA-S21.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C153-CHA-S21.chrY.freeze.fa -bed C153-CHA-S21.gaps.bed -fo C153-CHA-S21.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C153-CHA-S21.gaps.fa > C153-CHA-S21.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C154-CBA01.chrY.freeze.fa -bed C154-CBA01.gaps.bed -fo C154-CBA01.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C154-CBA01.gaps.fa > C154-CBA01.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/C155-CBA02.chrY.freeze.fa -bed C155-CBA02.gaps.bed -fo C155-CBA02.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa C155-CBA02.gaps.fa > C155-CBA02.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/KOR02.chrY.freeze.fa -bed KOR02.gaps.bed -fo KOR02.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa KOR02.gaps.fa > KOR02.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/KOR02.chrY.freeze.fa -bed KOR02.gaps.bed -fo KOR02.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa KOR02.gaps.fa > KOR02.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/KOR05.chrY.freeze.fa -bed KOR05.gaps.bed -fo KOR05.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa KOR05.gaps.fa > KOR05.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/KOR06.chrY.freeze.fa -bed KOR06.gaps.bed -fo KOR06.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa KOR06.gaps.fa > KOR06.gaps.paf
bedtools getfasta -fi ~/LiuJing/00_chrY/Freezed/Freeze_v0.9/KOR06.chrY.freeze.fa -bed KOR06.gaps.bed -fo KOR06.gaps.fa
minimap2 -cx asm5 -t4 --cs CHM13.chrY.fa KOR06.gaps.fa > KOR06.gaps.paf
