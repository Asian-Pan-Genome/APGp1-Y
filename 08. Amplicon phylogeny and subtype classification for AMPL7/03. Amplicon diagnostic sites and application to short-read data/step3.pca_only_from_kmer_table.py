#!/usr/bin/env python3
import argparse
import pandas as pd
import numpy as np
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt

############################################################
# 参数
############################################################

def parse_args():
	parser = argparse.ArgumentParser(
		description="PCA clustering based only on kmer_table (no filtering)"
	)

	parser.add_argument("--kmer_table", required=True,
						help="Merged site × sample kmer count table")

	parser.add_argument("--n_pca", type=int, default=5,
						help="Number of PCA components (default=5)")

	parser.add_argument("--out_prefix", default="PCA_only",
						help="Output prefix")

	return parser.parse_args()

############################################################
# 主流程
############################################################

def main():

	args = parse_args()

	########################################################
	# 读取输入
	########################################################

	df = pd.read_csv(args.kmer_table, sep="\t")

	########################################################
	# 计算 f_alt
	########################################################

	df["signal"] = df["Ref_Count"] + df["Alt_Count"]
	df["f_alt"] = df["Alt_Count"] / df["signal"]
	df.loc[df["signal"] == 0, "f_alt"] = np.nan

	########################################################
	# 构建 PCA 矩阵
	########################################################

	matrix = (
		df
		.pivot_table(
			index="Sample",
			columns=["Amp", "Pos"],
			values="f_alt"
		)
		.dropna(axis=1)
	)

	print(f"PCA matrix shape: {matrix.shape}")

	########################################################
	# PCA
	########################################################

	pca = PCA(n_components=args.n_pca)
	coords = pca.fit_transform(matrix.values)

	pca_df = pd.DataFrame(
		coords,
		index=matrix.index,
		columns=[f"PC{i+1}" for i in range(args.n_pca)]
	)

	########################################################
	# 输出
	########################################################

	matrix.to_csv(
		f"{args.out_prefix}.PCA_input.matrix.tsv",
		sep="\t"
	)

	pca_df.to_csv(
		f"{args.out_prefix}.PCA_coordinates.tsv",
		sep="\t"
	)

	with open(f"{args.out_prefix}.PCA_variance.txt", "w") as f:
		for i, v in enumerate(pca.explained_variance_ratio_):
			f.write(f"PC{i+1}\t{v:.4f}\n")

	########################################################
	# PCA plot（PC1 vs PC2）
	########################################################

	plt.figure(figsize=(6, 6))
	plt.scatter(pca_df["PC1"], pca_df["PC2"], alpha=0.7)

	plt.xlabel("PC1")
	plt.ylabel("PC2")
	plt.tight_layout()
	plt.savefig(f"{args.out_prefix}.PCA_PC1_PC2.pdf")

############################################################

if __name__ == "__main__":
	main()
