import argparse
import pysam
from collections import defaultdict


def parse_args():
	parser = argparse.ArgumentParser(
		description="Raw ref/alt kmer counting per site (strand-aware, multi-map inclusive)"
	)
	parser.add_argument("--kmer_db", required=True)
	parser.add_argument("--bam", required=True)
	parser.add_argument("--target_region", required=True,
						help="chr:start-end (sites region)")
	parser.add_argument("--control_region", required=True,
						help="chr:start-end (background depth only)")
	parser.add_argument("--out_prefix", required=True)
	return parser.parse_args()


def revcomp(seq):
	table = str.maketrans("ACGTNacgtn", "TGCANtgcan")
	return seq.translate(table)[::-1]


def load_kmer_db(db_file):
	"""
	site_info[pos] = {
		ref_id, ref_seq,
		alt_id, alt_seq
	}

	kmer_to_site[kmer_seq] = (pos, 'ref' or 'alt')
	"""
	site_info = {}
	kmer_to_site = {}
	k_sizes = set()

	with open(db_file) as f:
		header = next(f)
		for line in f:
			parts = line.rstrip().split("\t")
			if len(parts) < 12:
				continue

			pos = parts[0]
			ref_ale = parts[1]
			alt_ale = parts[2]
			frq_str = parts[3]
			amp = parts[4]
			k = int(parts[6])
			k_sizes.add(k)

			ref_id, ref_seq = parts[8], parts[9]
			alt_id, alt_seq = parts[10], parts[11]

			site_info[pos] = {
				"ref_ale": ref_ale,
				"alt_ale": alt_ale,
				"frq_str": frq_str,
				"amp": amp,
				"ref_seq": ref_seq,
				"alt_seq": alt_seq,
			}

			kmer_to_site[ref_seq] = (pos, "ref")
			kmer_to_site[alt_seq] = (pos, "alt")

	return site_info, kmer_to_site, sorted(k_sizes)


def count_kmers_in_region(bam, region, kmer_to_site, k_sizes):
	chrom, coords = region.split(":")
	start, end = map(int, coords.split("-"))

	counts = defaultdict(lambda: {"ref": 0, "alt": 0})

	for read in bam.fetch(
		chrom, start, end, multiple_iterators=True
	):
		seq = read.query_sequence
		if not seq:
			continue

		# strand normalization
		if read.is_reverse:
			seq = revcomp(seq)

		L = len(seq)
		for k in k_sizes:
			if L < k:
				continue
			for i in range(L - k + 1):
				sub = seq[i:i + k]
				if sub in kmer_to_site:
					pos, allele = kmer_to_site[sub]
					counts[pos][allele] += 1

	return counts


def mean_depth(bam, region):
	chrom, coords = region.split(":")
	start, end = map(int, coords.split("-"))

	total = 0
	npos = 0

	for pileup in bam.pileup(
		chrom, start, end, truncate=True
	):
		total += pileup.nsegments
		npos += 1

	if npos == 0:
		return 0.0
	return total / npos


def main():
	args = parse_args()

	site_info, kmer_to_site, k_sizes = load_kmer_db(args.kmer_db)
	bam = pysam.AlignmentFile(args.bam, "rb")

	# count ref / alt kmers in target region
	site_counts = count_kmers_in_region(
		bam, args.target_region, kmer_to_site, k_sizes
	)

	# control region depth
	ctrl_depth = mean_depth(bam, args.control_region)

	# output site-level kmer counts
	with open(f"{args.out_prefix}.site_kmer_counts.tsv", "w") as out:
		out.write(
			"Pos\tRef_Allele\tAlt_Allele\tFrq_Str\tAmp\t"
			"Ref_Kmer_Seq\tRef_Count\tAlt_Kmer_Seq\tAlt_Count\tControl_Depth\n"
		)

		for pos in sorted(site_info, key=lambda x: int(x)):
			info = site_info[pos]
			ref_cnt = site_counts[pos]["ref"]
			alt_cnt = site_counts[pos]["alt"]

			out.write(
				f"{pos}\t{info['ref_ale']}\t{info['alt_ale']}\t{info['frq_str']}\t{info['amp']}\t"
				f"{info['ref_seq']}\t{ref_cnt}\t\t{info['alt_seq']}\t{alt_cnt}\t{ctrl_depth:.2f}\n"
			)


if __name__ == "__main__":
	main()

