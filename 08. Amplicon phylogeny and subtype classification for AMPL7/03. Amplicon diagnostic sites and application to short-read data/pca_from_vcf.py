#!/usr/bin/env python3
import argparse
from cyvcf2 import VCF
import numpy as np
from sklearn.decomposition import PCA

def main():
    parser = argparse.ArgumentParser(description="PCA including INDELs from VCF")
    parser.add_argument("--vcf", required=True, help="Input VCF")
    parser.add_argument("--out", required=True, help="Output prefix")
    parser.add_argument("--pca_n", type=int, default=10, help="Number of PCs")
    args = parser.parse_args()

    vcf = VCF(args.vcf, gts012=True)  # Force GT→0/1/2 coding, even with INDELs
    samples = vcf.samples
    print(f"Samples: {len(samples)}")

    mat = []

    print("Reading VCF and extracting genotypes...")
    for i, variant in enumerate(vcf):
        gt = variant.gt_types  # 0,1,2,3(=unknown)
        gt = np.where(gt == 3, np.nan, gt)   # convert missing to NaN
        mat.append(gt)

        if (i+1) % 50000 == 0:
            print(f"Processed {i+1} variants...")

    mat = np.array(mat)
    print("Genotype matrix shape:", mat.shape)

    # Remove variants all missing
    mask = ~np.all(np.isnan(mat), axis=1)
    mat = mat[mask]

    # Mean-impute missing genotypes
    col_mean = np.nanmean(mat, axis=1)
    inds = np.where(np.isnan(mat))
    mat[inds] = np.take(col_mean, inds[0])

    print("Running PCA...")
    pca = PCA(n_components=args.pca_n)
    pcs = pca.fit_transform(mat.T)

    # Save eigenvalues
    eigvals = pca.explained_variance_
    np.savetxt(f"{args.out}.eigenval", eigvals, fmt="%.6f")

    # Save explained variance ratio
    eigvar = pca.explained_variance_ratio_
    np.savetxt(f"{args.out}.eigenvec.percvar", eigvar, fmt="%.6f")

    # Save eigenvectors in plink-like format
    with open(f"{args.out}.eigenvec", "w") as f:
        for sid, sample in enumerate(samples):
            pcs_str = "\t".join([f"{x:.6f}" for x in pcs[sid]])
            f.write(f"{sample}\t{sample}\t{pcs_str}\n")

    print("PCA completed.")
    print(f"Outputs written:\n  {args.out}.eigenval\n  {args.out}.eigenvec\n  {args.out}.eigenvec.percvar")

if __name__ == "__main__":
    main()

