## Phylogeny Pipeline for DYZ repeats

### DYZ1: K-mer Approach
This module analyzes DYZ1 repeats by calculating Mash distances on ~10Kb segmented HSat3 bins.

- **Tools:** `kmer-db` (v1.11.1), `FastME` (v2.0)
- **Key Steps:**
    1.  Segment HSat3 regions into 10Kb bins.
    2.  Calculate pairwise distances (Mash distance).
    3.  Construct NJ tree (Selected k-mer size: **9**).

### DYZ2: Sequence Alignment Approach
This module builds the phylogeny of DYZ2 based on conserved HSATI and AluY elements.

* **Tools:** `MAFFT` (v7.505), `IQ-TREE` (v2.1.4)

* **Commands:**
    ```bash
    # Alignment
    mafft --auto input.fasta > output.aln

    # Tree Construction
    iqtree -s output.aln -bb 1000 -bnni -m TEST
    ```

*Visualization performed with iTOL (v7.4).*
