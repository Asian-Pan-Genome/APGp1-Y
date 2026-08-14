#!/usr/bin/env python3
"""Independently validate predefined DYZ G2/G3 subfamilies using k-mers.

The workflow extracts canonical k-mers, calculates pairwise Mash distances from
Jaccard similarities, performs principal coordinates analysis (PCoA), builds an
UPGMA tree, scans alternative cluster numbers, and evaluates agreement with the
predefined G2/G3 labels by adjusted Rand index (ARI) and cross-validated KNN.
The input FASTA is expected to have already passed length filtering and exact
sequence dereplication.
"""

import argparse
import json
import os
import time

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from scipy.cluster.hierarchy import fcluster, linkage, to_tree
from scipy.sparse import csr_matrix
from scipy.spatial.distance import squareform
from sklearn.metrics import (
    adjusted_rand_score,
    calinski_harabasz_score,
    confusion_matrix,
    davies_bouldin_score,
    silhouette_score,
)
from sklearn.model_selection import LeaveOneOut, StratifiedKFold, cross_val_predict
from sklearn.neighbors import KNeighborsClassifier


CODE = np.full(256, -1, dtype=np.int8)
for base, value in (("A", 0), ("C", 1), ("G", 2), ("T", 3)):
    CODE[ord(base)] = value
    CODE[ord(base.lower())] = value
COMP = {0: 3, 1: 2, 2: 1, 3: 0}
PALETTE = [
    "#e6194b", "#3cb44b", "#ffe119", "#4363d8", "#f58231",
    "#911eb4", "#46f0f0", "#f032e6", "#bcf60c", "#fabebe",
    "#008080", "#e6beff", "#9a6324", "#800000", "#808000",
    "#000075", "#808080", "#ffd8b1", "#aaffc3", "#000000",
]


def read_fasta(path):
    records, header, chunks = [], None, []
    with open(path, encoding="utf-8") as handle:
        for line in handle:
            line = line.rstrip("\r\n")
            if not line:
                continue
            if line.startswith(">"):
                if header is not None:
                    records.append((header, "".join(chunks)))
                header, chunks = line[1:].strip(), []
            else:
                chunks.append(line)
    if header is not None:
        records.append((header, "".join(chunks)))
    if not records:
        raise ValueError(f"No FASTA records were found in {path}")
    return records


def read_annotations(path):
    sep = "\t" if path.lower().endswith((".tsv", ".txt")) else ","
    annotations = pd.read_csv(
        path, sep=sep, header=None, names=["id", "type"], dtype=str,
        comment="#", usecols=[0, 1]
    )
    annotations = annotations.dropna().apply(lambda col: col.str.strip())
    duplicated = annotations["id"].duplicated(keep=False)
    if duplicated.any():
        examples = ", ".join(annotations.loc[duplicated, "id"].head(5))
        raise ValueError(f"Annotation IDs must be unique; duplicates include: {examples}")
    return annotations


def sanitize(label):
    return "".join("_" if char in " ()[]:;,'\t#" else char for char in str(label))


def canonical_kmer_codes(sequence, k):
    mask, shift = (1 << (2 * k)) - 1, 2 * (k - 1)
    forward = reverse = valid_length = 0
    kmers = set()
    values = CODE[np.frombuffer(sequence.encode("ascii", "replace"), dtype=np.uint8)]
    for value in values.tolist():
        if value < 0:
            forward = reverse = valid_length = 0
            continue
        forward = ((forward << 2) | value) & mask
        reverse = (reverse >> 2) | (COMP[value] << shift)
        valid_length += 1
        if valid_length >= k:
            kmers.add(min(forward, reverse))
    return kmers


def build_presence_matrix(records, k, ubiquitous_threshold):
    row_arrays, code_arrays = [], []
    for index, (_, sequence) in enumerate(records):
        kmers = canonical_kmer_codes(sequence, k)
        if kmers:
            code_arrays.append(np.asarray(list(kmers), dtype=np.uint64))
            row_arrays.append(np.full(len(kmers), index, dtype=np.int32))
        if (index + 1) % 1000 == 0 or index + 1 == len(records):
            print(f"  k={k}: extracted k-mers from {index + 1}/{len(records)} sequences", flush=True)
    if not code_arrays:
        raise ValueError(f"No valid {k}-mers were extracted")
    all_codes, all_rows = np.concatenate(code_arrays), np.concatenate(row_arrays)
    unique_codes, columns = np.unique(all_codes, return_inverse=True)
    matrix = csr_matrix(
        (np.ones(all_rows.size, dtype=np.float32), (all_rows, columns)),
        shape=(len(records), unique_codes.size),
    )
    total = unique_codes.size
    if ubiquitous_threshold < 1.0:
        keep = np.asarray((matrix > 0).sum(axis=0)).ravel() <= ubiquitous_threshold * len(records)
        matrix = matrix[:, keep]
    return matrix, total, matrix.shape[1]


def mash_distance(matrix, k):
    binary = (matrix > 0).astype(np.float32)
    intersections = (binary @ binary.T).toarray().astype(np.float64)
    sizes = np.asarray(binary.sum(axis=1)).ravel()
    unions = sizes[:, None] + sizes[None, :] - intersections
    with np.errstate(divide="ignore", invalid="ignore"):
        jaccard = np.where(unions > 0, intersections / unions, 0.0)
        distance = -(1.0 / k) * np.log(2.0 * jaccard / (1.0 + jaccard))
    np.fill_diagonal(distance, 0.0)
    finite = distance[np.isfinite(distance)]
    distance[~np.isfinite(distance)] = finite.max() if finite.size else 1.0
    distance[distance < 0] = 0.0
    return (distance + distance.T) / 2.0


def pcoa(distance, n_axes=10):
    n = distance.shape[0]
    centering = np.eye(n) - np.ones((n, n)) / n
    matrix = -0.5 * centering.dot(distance ** 2).dot(centering)
    values, vectors = np.linalg.eigh((matrix + matrix.T) / 2.0)
    order = np.argsort(values)[::-1]
    values, vectors = values[order], vectors[:, order]
    positive = values > 1e-9
    values, vectors = values[positive], vectors[:, positive]
    if values.size < 2:
        raise ValueError("PCoA produced fewer than two positive axes")
    n_axes = min(n_axes, values.size)
    coordinates = vectors[:, :n_axes] * np.sqrt(values[:n_axes])
    explained = values[:n_axes] / values.sum()
    return coordinates, explained


def linkage_to_newick(linkage_matrix, labels):
    tree, nodes = to_tree(linkage_matrix, rd=True)
    parts = [None] * len(nodes)
    for node in nodes:
        if node.is_leaf():
            parts[node.id] = sanitize(labels[node.id])
        else:
            left_length = max(node.dist - node.left.dist, 0.0)
            right_length = max(node.dist - node.right.dist, 0.0)
            parts[node.id] = (
                f"({parts[node.left.id]}:{left_length:.6f},"
                f"{parts[node.right.id]}:{right_length:.6f})"
            )
    return parts[tree.id] + ";"


def evaluate_knn(coordinates, labels, neighbors):
    labels = pd.Series(labels, dtype=str)
    minimum = labels.value_counts().min()
    n_neighbors = min(neighbors, max(1, minimum - 1))
    classifier = KNeighborsClassifier(n_neighbors=n_neighbors)
    if minimum >= 3:
        folds = min(5, minimum)
        cv = StratifiedKFold(n_splits=folds, shuffle=True, random_state=42)
        cv_name = f"{folds}-fold stratified CV"
    else:
        cv, cv_name = LeaveOneOut(), "leave-one-out CV"
    predictions = cross_val_predict(classifier, coordinates, labels, cv=cv)
    classes = np.unique(labels)
    matrix = confusion_matrix(labels, predictions, labels=classes)
    table = pd.DataFrame(matrix, index=[f"true_{x}" for x in classes], columns=[f"pred_{x}" for x in classes])
    return float(np.mean(predictions == labels)), cv_name, table


def plot_pcoa(coordinates, explained, labels, path, k, title):
    figure, axis = plt.subplots(figsize=(8, 7))
    labels = np.asarray(labels, dtype=str)
    color_map = {label: PALETTE[i % len(PALETTE)] for i, label in enumerate(pd.unique(labels))}
    for label in pd.unique(labels):
        selected = labels == label
        axis.scatter(coordinates[selected, 0], coordinates[selected, 1], s=18,
                     color=color_map[label], label=label, alpha=0.8, linewidths=0)
    axis.set_xlabel(f"PCo1 ({explained[0] * 100:.1f}%)")
    axis.set_ylabel(f"PCo2 ({explained[1] * 100:.1f}%)")
    axis.set_title(f"{title}: k-mer PCoA (k={k})")
    axis.legend(title="Age group", bbox_to_anchor=(1.03, 1), loc="upper left")
    figure.tight_layout()
    figure.savefig(path, dpi=300)
    plt.close(figure)
    return color_map


def plot_cluster_scan(table, path, k):
    if table.empty:
        return
    figure, left = plt.subplots(figsize=(8, 4.5))
    left.plot(table["n_clusters"], table["silhouette"], "o-", color="tab:red")
    left.set_xlabel("Number of clusters")
    left.set_ylabel("Silhouette score (higher is better)", color="tab:red")
    right = left.twinx()
    right.plot(table["n_clusters"], table["davies_bouldin"], "s--", color="tab:blue")
    right.set_ylabel("Davies-Bouldin index (lower is better)", color="tab:blue")
    left.set_title(f"Cluster-number validation (k={k})")
    figure.tight_layout()
    figure.savefig(path, dpi=300)
    plt.close(figure)


def run_one_k(records, metadata, k, output_dir, args):
    started = time.time()
    k_dir = os.path.join(output_dir, f"k{k}")
    os.makedirs(k_dir, exist_ok=True)
    matrix, total_kmers, retained_kmers = build_presence_matrix(records, k, args.ubiquitous_threshold)
    distance = mash_distance(matrix, k)
    np.savez_compressed(os.path.join(k_dir, "mash_dist.npz"), distance=distance)
    coordinates, explained = pcoa(distance)
    tree = linkage(squareform(distance, checks=False), method="average")
    np.save(os.path.join(k_dir, "linkage.npy"), tree)
    with open(os.path.join(k_dir, "tree.nwk"), "w", encoding="utf-8") as handle:
        handle.write(linkage_to_newick(tree, metadata["id"].tolist()) + "\n")

    scans = []
    for count in range(2, min(args.max_clusters, len(records) - 1) + 1):
        clusters = fcluster(tree, t=count, criterion="maxclust")
        if np.unique(clusters).size < 2:
            continue
        scans.append({
            "n_clusters": count,
            "silhouette": silhouette_score(distance, clusters, metric="precomputed"),
            "calinski_harabasz": calinski_harabasz_score(coordinates, clusters),
            "davies_bouldin": davies_bouldin_score(coordinates, clusters),
        })
    scan_table = pd.DataFrame(scans)
    scan_table.to_csv(os.path.join(k_dir, "cluster_number_scan.tsv"), sep="\t", index=False)
    best_count = int(scan_table.loc[scan_table["silhouette"].idxmax(), "n_clusters"])
    best_clusters = fcluster(tree, t=best_count, criterion="maxclust")

    accuracy, cv_name, confusion = evaluate_knn(
        coordinates[:, :min(5, coordinates.shape[1])], metadata["type"], args.knn_neighbors
    )
    confusion.to_csv(os.path.join(k_dir, "knn_confusion_matrix.tsv"), sep="\t")
    ari = adjusted_rand_score(metadata["type"], best_clusters)

    coordinate_table = metadata.copy()
    for axis in range(coordinates.shape[1]):
        coordinate_table[f"PCo{axis + 1}"] = coordinates[:, axis]
    coordinate_table["cluster_best"] = best_clusters
    coordinate_table.to_csv(os.path.join(k_dir, "pcoa_and_clusters.tsv"), sep="\t", index=False)

    color_map = plot_pcoa(
        coordinates, explained, metadata["type"], os.path.join(k_dir, "pcoa_by_age_group.pdf"),
        k, args.title
    )
    plot_cluster_scan(scan_table, os.path.join(k_dir, "cluster_scan_metrics.pdf"), k)
    with open(os.path.join(k_dir, "itol_age_group_colorstrip.txt"), "w", encoding="utf-8") as handle:
        handle.write("DATASET_COLORSTRIP\nSEPARATOR TAB\nDATASET_LABEL\tAge_group\n")
        handle.write("COLOR\t#000000\nSTRIP_WIDTH\t30\nDATA\n")
        for sequence_id, label in zip(metadata["id"], metadata["type"]):
            handle.write(f"{sanitize(sequence_id)}\t{color_map[label]}\t{label}\n")

    summary = {
        "k": k,
        "n_sequences": len(records),
        "n_kmers_total": total_kmers,
        "n_kmers_retained": retained_kmers,
        "best_n_clusters_by_silhouette": best_count,
        "best_silhouette_score": float(scan_table["silhouette"].max()),
        "knn_annotation_accuracy": accuracy,
        "knn_cross_validation": cv_name,
        "adjusted_rand_index_vs_annotation": float(ari),
        "runtime_seconds": round(time.time() - started, 1),
    }
    with open(os.path.join(k_dir, "summary.json"), "w", encoding="utf-8") as handle:
        json.dump(summary, handle, indent=2)
    return summary


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fasta", required=True, help="FASTA containing one DYZ repeat unit per record")
    parser.add_argument("--annotations", required=True, help="Two-column, headerless TSV/CSV: sequence ID and age group")
    parser.add_argument("--outdir", required=True, help="Output directory")
    parser.add_argument("--k_values", default="21,25,31", help="Comma-separated canonical k-mer sizes (maximum 31)")
    parser.add_argument("--max_clusters", type=int, default=30, help="Largest cluster number to evaluate")
    parser.add_argument("--knn_neighbors", type=int, default=5, help="Number of KNN neighbors")
    parser.add_argument("--ubiquitous_threshold", type=float, default=1.0,
                        help="Discard k-mers present above this fraction of sequences")
    args = parser.parse_args()
    args.title = "DYZ G2/G3 validation"
    k_values = [int(value) for value in args.k_values.split(",") if value.strip()]
    if not k_values or any(value < 1 or value > 31 for value in k_values):
        parser.error("--k-values must contain integers between 1 and 31")
    if not 0 < args.ubiquitous_threshold <= 1:
        parser.error("--ubiquitous-threshold must be in (0, 1]")

    records = read_fasta(args.fasta)
    annotations = read_annotations(args.annotations)
    metadata = pd.DataFrame({"id": [record[0] for record in records]})
    metadata = metadata.merge(annotations, on="id", how="left", validate="one_to_one")
    missing = metadata["type"].isna()
    if missing.any():
        examples = ", ".join(metadata.loc[missing, "id"].head(5))
        raise ValueError(f"{missing.sum()} FASTA IDs lack annotations; examples: {examples}")
    metadata = metadata[metadata["type"].isin(["G2", "G3"])].copy()
    keep_ids = set(metadata["id"])
    records = [record for record in records if record[0] in keep_ids]
    if len(records) < 3 or metadata["type"].nunique() != 2:
        parser.error("The filtered input must contain annotated sequences from both G2 and G3")
    metadata = metadata.set_index("id").loc[[record[0] for record in records]].reset_index()
    os.makedirs(args.outdir, exist_ok=True)
    metadata.to_csv(os.path.join(args.outdir, "metadata.tsv"), sep="\t", index=False)
    summaries = [run_one_k(records, metadata, k, args.outdir, args) for k in k_values]
    pd.DataFrame(summaries).to_csv(
        os.path.join(args.outdir, "summary_all_k.tsv"), sep="\t", index=False
    )


if __name__ == "__main__":
    main()
