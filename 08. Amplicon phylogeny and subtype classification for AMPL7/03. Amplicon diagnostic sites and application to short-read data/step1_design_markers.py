import sys
import argparse
from Bio import AlignIO
from collections import defaultdict

def parse_args():
	parser = argparse.ArgumentParser(description="Step 1 V5: Generate Paired Wide-Format K-mers")
	
	# 必需参数
	parser.add_argument("--msa", required=True, help="Input MSA file (fasta format, must contain gaps)")
	parser.add_argument("--class_file", required=True, help="Tab-separated: SequenceID <tab> SubGroup")
	parser.add_argument("--site_file", required=True, help="Divergent sites file (Header optional)")
	parser.add_argument("--ref_id", required=True, help="The Exact Sequence ID in MSA used for coordinates in site_file")
	parser.add_argument("--output", required=True, help="Output K-mer database file (TSV)")
	
	# 可选参数
	parser.add_argument("--k_sizes", type=str, default="21,25,31", help="Comma-separated k-mer sizes (default: 21,25,31)")
	
	return parser.parse_args()

def parse_msa_and_get_ref(msa_file, ref_id, seq_to_group):
	"""
	解析 MSA，同时完成两个任务：
	1. 提取指定的 Ref 序列（用于坐标映射）。
	2. 将所有序列按 Subgroup 分组（用于构建 Consensus）。
	"""
	print(f"[Info] Loading MSA: {msa_file}...")
	alignment = AlignIO.read(msa_file, "fasta")
	
	group_seqs = defaultdict(list)
	ref_seq_str = None
	found_ref = False
	
	for record in alignment:
		# 严格匹配 Ref ID
		if record.id == ref_id:
			ref_seq_str = str(record.seq)
			found_ref = True
		
		# 分组
		if record.id in seq_to_group:
			group_seqs[seq_to_group[record.id]].append(str(record.seq))
			
	if not found_ref:
		print(f"[Error] The ref_id '{ref_id}' was not found in the MSA file headers.")
		sys.exit(1)
		
	return group_seqs, ref_seq_str

def build_consensus_map(group_seqs):
	"""
	为每个 Subgroup 构建带有 Gap 的一致性序列
	逻辑：简单多数原则，忽略 N
	"""
	consensus_map = {}
	print(f"[Info] Building consensus for groups: {list(group_seqs.keys())}")
	
	for grp, seqs in group_seqs.items():
		if not seqs: continue
		length = len(seqs[0])
		cons = []
		# 逐列扫描
		for i in range(length):
			counts = defaultdict(int)
			for s in seqs:
				base = s[i].upper()
				if base != 'N': 
					counts[base] += 1
			
			if not counts:
				cons.append('N') # 全是 N
			else:
				# 取出现次数最多的碱基（包括 Gap '-'）
				best_base = max(counts, key=counts.get)
				cons.append(best_base)
				
		consensus_map[grp] = "".join(cons)
	return consensus_map

def map_ref_to_msa(ref_seq):
	"""
	建立 Ref 物理坐标 (1-based) 到 MSA Column Index (0-based) 的映射
	"""
	mapping = {}
	phy_pos = 0 
	for i, base in enumerate(ref_seq):
		if base != '-': 
			phy_pos += 1 
			mapping[phy_pos] = i
	return mapping

def extract_context_kmer(consensus_seq, center_col, k, shift):
	"""
	上下文感知的 K-mer 提取：跳过 Gap，获取物理序列
	"""
	bases_needed_left = int(k * shift)
	
	# 1. 向左回溯寻找起始列
	scan_ptr = center_col - 1
	found = 0
	while found < bases_needed_left and scan_ptr >= 0:
		if consensus_seq[scan_ptr] != '-':
			found += 1
		scan_ptr -= 1
	
	start_col = scan_ptr + 1
	
	# 2. 向右收集 k 个实碱基
	collected = []
	curr = start_col
	while len(collected) < k and curr < len(consensus_seq):
		base = consensus_seq[curr]
		if base != '-':
			collected.append(base)
		curr += 1
		
	if len(collected) == k:
		return "".join(collected)
	return None

def main():
	args = parse_args()
	k_sizes = [int(x) for x in args.k_sizes.split(",")]
	
	# 定义判定阈值
	FREQ_ALT_THRESHOLD = 0.9
	FREQ_REF_THRESHOLD = 0.1

	# 1. 加载分类信息
	seq_to_group = {}
	try:
		with open(args.class_file) as f:
			for line in f:
				parts = line.strip().split()
				if len(parts) >= 2:
					seq_to_group[parts[0]] = parts[1]
	except FileNotFoundError:
		print(f"[Error] Class file not found: {args.class_file}")
		sys.exit(1)

	# 2. 解析 MSA
	group_seqs, ref_seq_str = parse_msa_and_get_ref(args.msa, args.ref_id, seq_to_group)
	
	# 3. 构建 Consensus 和 坐标映射
	consensus_map = build_consensus_map(group_seqs)
	pos_map = map_ref_to_msa(ref_seq_str)
	
	print(f"[Info] Ref coordinate mapping built based on '{args.ref_id}'.")

	# 4. 准备输出文件和日志
	log_file = args.output + ".log"
	# buffering=1 确保日志实时写入行
	log = open(log_file, "w", buffering=1) 
	
	out_lines = []
	# 宽格式 Header
	header = [
		"Pos", "Ref_Base", "Alt_Base", "Frq_Str", "Amp", "Amp_Type",
		"K_Size", "Shift",
		"Ref_Kmer_ID", "Ref_Kmer_Seq", 
		"Alt_Kmer_ID", "Alt_Kmer_Seq"
	]
	out_lines.append("\t".join(header))
	
	subgroups = None # 动态探测 Subgroup 列表

	print("[Info] Processing divergent sites...")
	
	with open(args.site_file) as f:
		for line_idx, line in enumerate(f):
			parts = line.strip().split()
			
			# 安全性检查
			if len(parts) < 4:
				continue
				
			# --- 智能表头跳过逻辑 ---
			# 如果第一列不是数字 (例如 "Pos" 或 "#Pos")，则视为表头跳过
			if not parts[0].isdigit():
				continue

			try:
				pos = int(parts[0])
				ref_base = parts[1]
				alt_base = parts[2]
				freq_str = parts[3] # e.g. "b1/b2/b3/b4:0.0/0.0/0.99/0.95"
				
				# --- 动态解析 Subgroup 名称 (仅执行一次) ---
				if subgroups is None:
					if ":" in freq_str:
						subgroups = freq_str.split(":")[0].split("/")
						print(f"[Info] Auto-detected subgroups: {subgroups}")
					else:
						log.write(f"Error_Line_{line_idx+1}: Column 4 format error (missing ':'): {freq_str}\n")
						continue

				# 解析频率数值
				val_part = freq_str.split(":")[1]
				freqs = [float(x) for x in val_part.split("/")]
			except Exception as e:
				log.write(f"Error_Line_{line_idx+1}: Parsing failed ({e}). Content: {line.strip()}\n")
				continue

			# --- 核心逻辑：鉴定 Alt (Amp) 和 Ref 组 ---
			alt_groups = []
			ref_groups = []
			
			for i, f_val in enumerate(freqs):
				if f_val >= FREQ_ALT_THRESHOLD:
					alt_groups.append(subgroups[i])
				elif f_val <= FREQ_REF_THRESHOLD:
					ref_groups.append(subgroups[i])
			
			# 检查是否有符合条件的组
			if not alt_groups:
				log.write(f"Skip_Pos_{pos}: No Alt group found (freq >= {FREQ_ALT_THRESHOLD}).\n")
				continue
			if not ref_groups:
				log.write(f"Skip_Pos_{pos}: No Ref group found (freq <= {FREQ_REF_THRESHOLD}).\n")
				continue
			
			# 联合标记 (例如 "b3,b4")
			target_amp_label = ",".join(alt_groups)
			
			# 提取模板选择：使用列表中的第一个组作为物理提取对象
			extraction_template = alt_groups[0]
			anchor_ref = ref_groups[0]
			
			# --- 坐标映射检查 ---
			if pos not in pos_map:
				log.write(f"Skip_Pos_{pos}: Coordinate likely in Gap of Reference sequence.\n")
				continue
			center_col = pos_map[pos]
			
			# --- Consensus 存在性检查 ---
			if extraction_template not in consensus_map:
				log.write(f"Skip_Pos_{pos}: Consensus missing for Alt group '{extraction_template}'.\n")
				continue
			if anchor_ref not in consensus_map:
				log.write(f"Skip_Pos_{pos}: Consensus missing for Ref group '{anchor_ref}'.\n")
				continue

			# --- 提取 K-mers ---
			for k in k_sizes:
				shifts = [0.25, 0.5, 0.75]
				for shift in shifts:
					# 提取 Ref Kmer
					kmer_ref = extract_context_kmer(consensus_map[anchor_ref], center_col, k, shift)
					# 提取 Alt Kmer
					kmer_alt = extract_context_kmer(consensus_map[extraction_template], center_col, k, shift)
					
					# 验证质量 (Check N or Edges)
					if not kmer_ref or 'N' in kmer_ref:
						log.write(f"Skip_Pos_{pos}_K{k}_S{shift}: Ref ({anchor_ref}) extraction failed (contains N or edge).\n")
						continue
					if not kmer_alt or 'N' in kmer_alt:
						log.write(f"Skip_Pos_{pos}_K{k}_S{shift}: Alt ({extraction_template}) extraction failed (contains N or edge).\n")
						continue
					
					# 生成 IDs
					ref_id = f"{pos}_{k}_{shift}_Ref"
					alt_id = f"{pos}_{k}_{shift}_Alt"
					
					# 构建输出行
					row = [
						str(pos), ref_base, alt_base, freq_str, 
						target_amp_label, # e.g. "b3,b4"
						"Alt_Target",
						str(k), str(shift),
						ref_id, kmer_ref,
						alt_id, kmer_alt
					]
					out_lines.append("\t".join(row))

	# 写入最终结果
	with open(args.output, "w") as out:
		out.write("\n".join(out_lines) + "\n")
		
	log.close()
	print(f"[Success] K-mer library generated: {args.output}")
	print(f"[Info] Detailed skip log: {log_file}")

if __name__ == "__main__":
	main()