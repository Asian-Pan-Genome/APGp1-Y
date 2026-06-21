#!/usr/bin/env python3

import sys
import os
import re
import argparse
from collections import defaultdict
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import LinearSegmentedColormap
import matplotlib.patches as patches

###########################################################
## read chain & extract annotation/color simultaneously
###########################################################

def read_chain(chain_file):
	family_dict = defaultdict(lambda: defaultdict(dict))
	amp_info = {} 
	with open(chain_file) as f:
		for line in f:
			line = line.strip()
			if line == "":
				continue
			tmp = line.split("\t")
			start_pos = int(tmp[1])
			end_pos = int(tmp[2])
			amp = tmp[3]
			strand = tmp[4]
			color = tmp[5]
			if amp not in amp_info:
				amp_info[amp] = {
					"start": start_pos,
					"end": end_pos,
					"strand": strand,
					"color": color
				}
			marker = tmp[6]
			m = re.match(r"([A-Za-z]+)_(\d+)_([A-Za-z]+)", marker)
			if m is None:
				continue
			family = m.group(1)
			pos = int(m.group(2))
			allele = m.group(3)
			if allele.upper() == "NA":
				continue
			family_dict[family][amp][pos] = allele
	return family_dict, amp_info

###########################################################
## downsample
###########################################################

def downsample_family(family_dict, cluster_bp):
	new_dict = defaultdict(lambda: defaultdict(dict))
	for family in family_dict:
		all_pos = set()
		for amp in family_dict[family]:
			all_pos.update(
				family_dict[family][amp].keys()
			)
		all_pos = sorted(all_pos)
		keep = []
		last = -100000000
		for pos in all_pos:
			if pos - last >= cluster_bp:
				keep.append(pos)
				last = pos
		keep = set(keep)
		for amp in family_dict[family]:
			for pos in keep:
				if pos in family_dict[family][amp]:
					new_dict[family][amp][pos] = \
						family_dict[family][amp][pos]
	return new_dict

###########################################################
## build windows
###########################################################

def build_windows(family_dict, window_bp, step_bp):
	windows = defaultdict(lambda: defaultdict(list))
	for family in family_dict:
		all_pos = []
		for amp in family_dict[family]:
			all_pos.extend(family_dict[family][amp].keys())
		if not all_pos:
			continue
		min_p = min(all_pos)
		max_p = max(all_pos)
		for amp in family_dict[family]:
			pos_list = sorted(family_dict[family][amp].keys())
			w_start = min_p
			while w_start <= max_p:
				w_end = w_start + window_bp
				sub_pos = [p for p in pos_list if w_start <= p < w_end]
				if sub_pos:
					marker_dict = {p: family_dict[family][amp][p] for p in sub_pos}
					center = (w_start + w_end) / 2.0
					windows[family][center].append({
						"family": family,
						"amp": amp,
						"start": w_start,
						"end": w_end,
						"center": center,
						"marker": marker_dict
					})
				w_start += step_bp
	return windows

###########################################################
## window similarity
###########################################################

def calc_window_similarity(window1, window2):
	marker1 = window1["marker"]
	marker2 = window2["marker"]
	shared = 0
	for pos in marker1:
		if pos not in marker2:
			continue
		if marker1[pos] == marker2[pos]:
			shared += 1
	total = min(len(marker1), len(marker2))
	if total == 0:
		return 0, 0
	return shared / total, total

###########################################################
## build dot matrix
###########################################################

def build_dot_matrix(windows1, windows2, min_similarity):
	dot_list = []
	family_list = sorted(
		set(windows1.keys()) &
		set(windows2.keys())
	)
	for family in family_list:
		centers1 = set(windows1[family].keys())
		centers2 = set(windows2[family].keys())
		common_centers = sorted(centers1 & centers2)
		for c in common_centers:
			target_windows = windows1[family][c]
			query_windows = windows2[family][c]
			for w1 in target_windows:
				for w2 in query_windows:
					sim, count = calc_window_similarity(w1, w2)
					if sim < min_similarity:
						continue
					dot_list.append({
						"family": family,
						"target_amp": w1["amp"],
						"query_amp": w2["amp"],
						"target_center": w1["center"],
						"query_center": w2["center"],
						"similarity": sim,
						"marker_count": count
					})
	return dot_list

###########################################################
## export dot matrix to table
###########################################################

def export_dot_matrix(dot_list, out_file):
	with open(out_file, 'w') as f:
		f.write("Family\tTarget_Amp\tTarget_Center\tQuery_Amp\tQuery_Center\tShared_Proportion\tMarker_Count\n")
		for dot in dot_list:
			f.write(f"{dot['family']}\t"
					f"{dot['target_amp']}\t{dot['target_center']}\t"
					f"{dot['query_amp']}\t{dot['query_center']}\t"
					f"{dot['similarity']:.4f}\t{dot['marker_count']}\n")

###########################################################
## convert reference coordinate to genome coordinate
###########################################################

def ref_to_global(ref_pos, amp, amp_info):
	start = amp_info[amp]["start"]
	end = amp_info[amp]["end"]
	strand = amp_info[amp]["strand"]
	if strand == "+":
		return start + ref_pos
	else:
		return end - ref_pos

def convert_dot_to_global(dot_list, anno1, anno2):
	X, Y, C, S = [], [], [], []
	for dot in dot_list:
		x = ref_to_global(
			dot["target_center"],
			dot["target_amp"],
			anno1
		)
		y = ref_to_global(
			dot["query_center"],
			dot["query_amp"],
			anno2
		)
		X.append(x)
		Y.append(y)
		C.append(dot["similarity"])
		S.append(dot["marker_count"])
	return X, Y, C, S

###########################################################
## plot dotplot
###########################################################

def plot_dotplot(X, Y, C, S, anno1, anno2, name1, name2, outfile):
	cmap = LinearSegmentedColormap.from_list("marker", ["#6699cc", "#DFE7C9", "#CC3333"])
	fig = plt.figure(figsize=(10,10))
	ax = plt.axes([0.1, 0.1, 0.7, 0.8])
	ax.set_box_aspect(1)
	S = np.array(S)
	if len(S) > 0:
		S_log = np.log10(S + 1)
		min_log = np.min(S_log)
		max_log = np.max(S_log)
		MAX_DOT_SIZE = 30.0
		MIN_DOT_SIZE = 1.0
		if max_log > min_log:
			S_scaled = MIN_DOT_SIZE + (S_log - min_log) / (max_log - min_log) * (MAX_DOT_SIZE - MIN_DOT_SIZE)
		else:
			S_scaled = np.full_like(S, MAX_DOT_SIZE, dtype=float)
	else:
		S_scaled = []
	sc = ax.scatter(
		X, Y, c=C, cmap=cmap, s=S_scaled, vmin=0, vmax=1, linewidths=0
	)

	# Colorbar
	cbar_ax = fig.add_axes([0.83, 0.25, 0.02, 0.3])
	cb = plt.colorbar(sc, cax=cbar_ax)
	cb.set_label("Shared allele proportion")

	# Size Legend
	if len(S) > 0 and max_log > min_log:
		S_min, S_max = np.min(S), np.max(S)
		if S_max > S_min:
			steps = np.linspace(np.log2(S_min + 1), np.log2(S_max + 1), 4)
			ref_S = np.unique(np.round(2**steps - 1).astype(int))
			ref_S_log = np.log2(ref_S + 1)
			ref_sizes = MIN_DOT_SIZE + (ref_S_log - min_log) / (max_log - min_log) * (MAX_DOT_SIZE - MIN_DOT_SIZE)
			handles = []
			for sz, count in zip(ref_sizes, ref_S):
				handles.append(ax.scatter([], [], s=sz, c="gray", alpha=0.8, label=str(count)))
			ax.legend(handles=handles, title="Marker Count", 
					  loc="lower left", bbox_to_anchor=(1.03, 0.65), 
					  frameon=False, borderpad=1)

	min_x = min([min(info["start"], info["end"]) for info in anno1.values()])
	max_x = max([max(info["start"], info["end"]) for info in anno1.values()])
	min_y = min([min(info["start"], info["end"]) for info in anno2.values()])
	max_y = max([max(info["start"], info["end"]) for info in anno2.values()])
	ax.set_xlim(min_x, max_x)
	ax.set_ylim(min_y, max_y)

	# Amplicon Colored Bars
	for amp, info in anno1.items():
		start = min(info["start"], info["end"])
		end = max(info["start"], info["end"])
		width = end - start
		rect = patches.Rectangle(
			(start, -0.015), width, 0.015,
			facecolor=info["color"], edgecolor='none',
			transform=ax.get_xaxis_transform(),
			clip_on=False, zorder=10
		)
		ax.add_patch(rect)

	for amp, info in anno2.items():
		start = min(info["start"], info["end"])
		end = max(info["start"], info["end"])
		height = end - start
		rect = patches.Rectangle(
			(-0.015, start), 0.015, height,
			facecolor=info["color"], edgecolor='none',
			transform=ax.get_yaxis_transform(),
			clip_on=False, zorder=10
		)
		ax.add_patch(rect)

	xtick, xlabel = [], []
	for amp in sorted(anno1.keys(), key=lambda x: min(anno1[x]["start"], anno1[x]["end"])):
		mid = (anno1[amp]["start"] + anno1[amp]["end"]) / 2
		xtick.append(mid)
		xlabel.append(amp)
		ax.axvline(min(anno1[amp]["start"], anno1[amp]["end"]), color="lightgray", lw=0.5, zorder=0)
	ytick, ylabel = [], []
	for amp in sorted(anno2.keys(), key=lambda x: min(anno2[x]["start"], anno2[x]["end"])):
		mid = (anno2[amp]["start"] + anno2[amp]["end"]) / 2
		ytick.append(mid)
		ylabel.append(amp)
		ax.axhline(min(anno2[amp]["start"], anno2[amp]["end"]), color="lightgray", lw=0.5, zorder=0)

	ax.set_xticks(xtick)
	ax.set_xticklabels(xlabel, fontsize=8)
	ax.set_yticks(ytick)
	ax.set_yticklabels(ylabel, fontsize=8)
	ax.tick_params(axis='x', pad=12)
	ax.tick_params(axis='y', pad=12)
	ax.set_xlabel(name1, fontsize=14, fontweight='bold', labelpad=15)
	ax.set_ylabel(name2, fontsize=14, fontweight='bold', labelpad=15)
	plt.savefig(outfile, dpi=600, bbox_inches='tight')
	plt.close()
	print(f"[INFO] Produce marker (Window) synteny to: {outfile}")

###########################################################
## main
###########################################################

def get_sample_name(filepath):
	return os.path.basename(filepath).split('.')[0]

if __name__ == "__main__":
	parser = argparse.ArgumentParser(description="Generate marker window dotplot for amplicon synteny.")
	parser.add_argument("target_chain", help="Target marker chain file (e.g., C020.tsv)")
	parser.add_argument("query_chain", help="Query marker chain file (e.g., C024.tsv)")
	parser.add_argument("output", help="Output PDF file name (e.g., output.pdf)")
	parser.add_argument("--cluster_bp", type=int, default=500, help="Downsample: keep 1 marker per X bp (default: 500)")
	parser.add_argument("--window_bp", type=int, default=10000, help="Sliding window size in bp (default: 10000)")
	parser.add_argument("--step_bp", type=int, default=5000, help="Sliding window step size in bp (default: 5000)")
	parser.add_argument("--min_sim", type=float, default=0.0, help="Minimum shared allele proportion (default: 0.0)")
	parser.add_argument("--out_table", type=str, default="", help="Optional output file for the raw shared proportion data table (.txt or .tsv)")

	args = parser.parse_args()
	name1 = get_sample_name(args.target_chain)
	name2 = get_sample_name(args.query_chain)
	print(f"[{name1}] vs [{name2}] analysis start...")
	family1, anno1 = read_chain(args.target_chain)
	family2, anno2 = read_chain(args.query_chain)
	family1 = downsample_family(family1, args.cluster_bp)
	family2 = downsample_family(family2, args.cluster_bp)
	windows1 = build_windows(family1, args.window_bp, args.step_bp)
	windows2 = build_windows(family2, args.window_bp, args.step_bp)
	dot_list = build_dot_matrix(windows1, windows2, args.min_sim)
	table_filename = args.out_table if args.out_table else args.output + ".txt"
	export_dot_matrix(dot_list, table_filename)
	X, Y, C, S = convert_dot_to_global(dot_list, anno1, anno2)
	plot_dotplot(X, Y, C, S, anno1, anno2, name1, name2, args.output)

