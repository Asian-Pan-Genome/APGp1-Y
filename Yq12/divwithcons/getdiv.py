import sys
from Bio import SeqIO
from Bio.Align import PairwiseAligner


def read_fa(input_file):
    """
    Reads a FASTA file and returns a list of sequences.
    """
    sequences = list(SeqIO.parse(input_file, "fasta"))
    return sequences


def pairwise(iseq, jseq):
    """
    Performs global pairwise alignment and calculates sequence identity.
    """
    aligner = PairwiseAligner()
    aligner.mode = 'global'

    alignments = aligner.align(iseq.seq, jseq.seq)
    alignment = alignments[0]
    matching = 0
    for (start_a, end_a), (start_b, end_b) in zip(*alignment.aligned):
        segment_a = iseq.seq[start_a:end_a]
        segment_b = jseq.seq[start_b:end_b]
        matching += sum(1 for a, b in zip(segment_a, segment_b) if a == b)
    shorter_length = min(len(iseq.seq), len(jseq.seq))
    identity = round(matching / shorter_length, 3) if shorter_length > 0 else 0
    return identity


def one_vs_all(i, sequences, output_file):
    """
    Compares one sequence to all others and writes pairwise distances to a file.
    """
    seq_names = [seq.id for seq in sequences]
    cluster_seqs = {i: i.split('@')[0] for i in seq_names}

    with open(output_file, "w") as outf:
        index = i + 1
        iseq = sequences[i]
        iseq_id = cluster_seqs[iseq.id]

        for j in range(index, len(cluster_seqs)):
            jseq = sequences[j]
            jseq_id = cluster_seqs[jseq.id]
            #print(iseq_id, jseq_id)
            identity = pairwise(iseq, jseq)
            dist = 1 - identity
            outf.write(f"{iseq_id}\t{jseq_id}\t{dist}\n")


if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python script.py <sequence_index> <input_fasta> <output_file>")
        sys.exit(1)

    i = int(sys.argv[1])  # Index of the sequence to compare
    input_file = sys.argv[2]  # Input FASTA file
    output_file = sys.argv[3]  # Output file for pairwise distances

    sequences = read_fa(input_file)
    one_vs_all(i, sequences, output_file)

