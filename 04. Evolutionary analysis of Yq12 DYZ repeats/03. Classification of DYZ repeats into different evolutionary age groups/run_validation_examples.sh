#!/usr/bin/env bash
set -euo pipefail

# Each FASTA below was prepared before this validation: DYZ1 units were length
# filtered, DYZ2 Alu-HSAT units shorter than 800 bp were removed, and fully
# redundant sequences were dereplicated. Separate FASTA files represent the
# independently selected sequence batches used for validation.

python validate_age_groups_by_kmer_pcoa.py --fasta KOR08.DYZ1.uniq.fa --annotations DYZ1.anno.tsv --outdir KOR08_DYZ1_L --k_values 15,21,25,31 --max_clusters 30
python validate_age_groups_by_kmer_pcoa.py --fasta C129-CYI01.DYZ1.uniq.fa --annotations DYZ1.anno.tsv --outdir C129-CYI01_DYZ1_L --k_values 15,21,25,31 --max_clusters 30
python validate_age_groups_by_kmer_pcoa.py --fasta C106-CZA06.DYZ1.uniq.fa --annotations DYZ1.anno.tsv --outdir C106-CZA06_DYZ1_L --k_values 15,21,25,31 --max_clusters 30
python validate_age_groups_by_kmer_pcoa.py --fasta C068-CHA-NE08.DYZ1.uniq.fa --annotations DYZ1.anno.tsv --outdir C068-CHA-NE08_DYZ1_L --k_values 15,21,25,31 --max_clusters 30
python validate_age_groups_by_kmer_pcoa.py --fasta C069-CHA-NE09.DYZ1.uniq.fa --annotations DYZ1.anno.tsv --outdir C069-CHA-NE09_DYZ1_L --k_values 15,21,25,31 --max_clusters 30

python validate_age_groups_by_kmer_pcoa.py --fasta C076-CHA-NE16.Alu_SAT.uniq.fa --annotations DYZ2.anno.tsv --outdir C076-CHA-NE16_DYZ2 --k_values 15,21,25,31 --max_clusters 30
python validate_age_groups_by_kmer_pcoa.py --fasta C110-CUG02.Alu_SAT.uniq.fa --annotations DYZ2.anno.tsv --outdir C110-CUG02_DYZ2 --k_values 15,21,25,31 --max_clusters 30
python validate_age_groups_by_kmer_pcoa.py --fasta C051-CHA-N11.Alu_SAT.uniq.fa --annotations DYZ2.anno.tsv --outdir C051-CHA-N11_DYZ2 --k_values 15,21,25,31 --max_clusters 30
python validate_age_groups_by_kmer_pcoa.py --fasta C137-CMH04.Alu_SAT.uniq.fa --annotations DYZ2.anno.tsv --outdir C137-CMH04_DYZ2 --k_values 15,21,25,31 --max_clusters 30
python validate_age_groups_by_kmer_pcoa.py --fasta C042-CHA-N02.Alu_SAT.uniq.fa --annotations DYZ2.anno.tsv --outdir C042-CHA-N02_DYZ2 --k_values 15,21,25,31 --max_clusters 30
