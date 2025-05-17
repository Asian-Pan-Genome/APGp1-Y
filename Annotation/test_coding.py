import argparse
from Bio import SeqIO

def count_stars_in_sequences(input_fasta):
    sequences_with_multiple_stars = []


    for record in SeqIO.parse(input_fasta, "fasta"):
        sequence = str(record.seq)
        star_count = sequence.count('*')


        if star_count > 1:
            sequences_with_multiple_stars.append((record.description, star_count))


    if sequences_with_multiple_stars:

        for description, count in sequences_with_multiple_stars:
            print(f"{description}: {count} '*' found")
    else:
        print("No sequences found with more than 1 '*'.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Detect sequences with more than 1 '*' in a FASTA file.")
    parser.add_argument("input", help="Input FASTA file containing protein sequences.")

    args = parser.parse_args()


    count_stars_in_sequences(args.input)
