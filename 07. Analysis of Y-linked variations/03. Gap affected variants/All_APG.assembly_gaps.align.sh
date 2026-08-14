#!/usr/bin/env bash

#SBATCH --job-name=Gaps
#SBATCH --partition=cpu64
#SBATCH --cpus-per-task=4
#SBATCH --mem=5G
#SBATCH --output=Gaps.o
#SBATCH --error=Gaps.e

set -euo pipefail

if [[ $# -lt 4 || $# -gt 5 ]]; then
    echo "Usage: $0 <sample_list> <assembly_dir> <gap_bed_dir> <CHM13_Y.fa> [output_dir]" >&2
    exit 1
fi

sample_list=$1
assembly_dir=$2
gap_bed_dir=$3
reference_fasta=$4
output_dir=${5:-.}

for required in bedtools minimap2; do
    if ! command -v "$required" >/dev/null 2>&1; then
        echo "Error: $required was not found in PATH." >&2
        exit 1
    fi
done

if [[ ! -f "$sample_list" ]]; then
    echo "Error: sample list not found: $sample_list" >&2
    exit 1
fi
if [[ ! -f "$reference_fasta" ]]; then
    echo "Error: reference FASTA not found: $reference_fasta" >&2
    exit 1
fi

mkdir -p "$output_dir"

while IFS= read -r sample || [[ -n "$sample" ]]; do
    sample=${sample%$'\r'}
    [[ -z "$sample" || "$sample" == \#* ]] && continue

    assembly_fasta="${assembly_dir}/${sample}.chrY.freeze.fa"
    gap_bed="${gap_bed_dir}/${sample}.gaps.bed"
    gap_fasta="${output_dir}/${sample}.gaps.fa"
    gap_paf="${output_dir}/${sample}.gaps.paf"

    if [[ ! -f "$assembly_fasta" ]]; then
        echo "Error: assembly FASTA not found for $sample: $assembly_fasta" >&2
        exit 1
    fi
    if [[ ! -f "$gap_bed" ]]; then
        echo "Error: gap BED not found for $sample: $gap_bed" >&2
        exit 1
    fi

    echo "Processing $sample"
    bedtools getfasta -fi "$assembly_fasta" -bed "$gap_bed" -fo "$gap_fasta"
    minimap2 -cx asm5 -t 4 --cs "$reference_fasta" "$gap_fasta" > "$gap_paf"
done < "$sample_list"

echo "Gap-adjacent sequence alignment completed."
