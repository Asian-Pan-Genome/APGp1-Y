import sys
import io
import csv
from Bio import Phylo
import numpy as np

def calculate_root_to_tip_distances(tree):
	root = tree.root
	distances = []
	for terminal in tree.get_terminals():
		distance = tree.distance(root, terminal)
		distances.append(distance)
	return distances

def calculate_cv(distances):
	mean_distance = np.mean(distances)
	std_distance = np.std(distances)
	cv = std_distance / mean_distance if mean_distance != 0 else 0
	return cv

def read_and_calculate_metrics(input_filename):
	metrics = []
	with open(input_filename, 'r') as file:
		reader = csv.reader(file, delimiter='\t')
		for row in reader:
			gene_tree_name = row[0]
			newick_str = row[1]
			tree = Phylo.read(io.StringIO(newick_str), 'newick')
			distances = calculate_root_to_tip_distances(tree)
			cv = calculate_cv(distances)
			sample_count = len(tree.get_terminals())
			metrics.append((gene_tree_name, sample_count, cv))
	return metrics

if __name__ == "__main__":
	if len(sys.argv) != 3:
		print("Usage: python calculate_cv.py <input_file> <output_file>")
		sys.exit(1)

	input_filename = sys.argv[1]
	output_filename = sys.argv[2]

	metrics = read_and_calculate_metrics(input_filename)
	
	with open(output_filename, 'w') as outfile:
		writer = csv.writer(outfile, delimiter='\t')
		for gene_tree_name, sample_count, cv in metrics:
			writer.writerow([gene_tree_name, sample_count, cv])
