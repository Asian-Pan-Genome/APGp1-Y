import os
import pandas as pd
import numpy as np
import joblib
from sklearn.decomposition import PCA  
from sklearn.preprocessing import Normalizer
from sklearn.feature_extraction.text import CountVectorizer


FASTA_FILE = "all.fa"
OUTPUT_DIR = "PCA_core_Results"
KMER_LENGTH = 15
MIN_SEQ_LENGTH = 100

def kmer_tokenizer(text):

    return text.split()

def extract_kmers(sequence, k):

    return [sequence[i:i+k] for i in range(len(sequence)-k+1)]

def read_fasta_and_process(file_path, k, min_length):
   
    print(f": {file_path}")
    ids = []
    kmer_strings = []
    
    if not os.path.exists(file_path):
        print(f"❌ {file_path}")
        return [], []

    with open(file_path, 'r') as f:
        seq = []
        seq_id = None
        for line in f:
            line = line.strip()
            if not line: continue
            
            if line.startswith('>'):
              
                if seq_id and seq:
                    full_seq = ''.join(seq)
                    if len(full_seq) >= min_length:
                        kmers = extract_kmers(full_seq, k)
                        if kmers:
                            ids.append(seq_id)
                            kmer_strings.append(' '.join(kmers))
                
                seq_id = line[1:].split()[0]
                seq = []
            else:
                seq.append(line.upper()) 

        if seq_id and seq:
            full_seq = ''.join(seq)
            if len(full_seq) >= min_length:
                kmers = extract_kmers(full_seq, k)
                if kmers:
                    ids.append(seq_id)
                    kmer_strings.append(' '.join(kmers))
                    
    return ids, kmer_strings

def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)

   
    ids, sequences = read_fasta_and_process(FASTA_FILE, KMER_LENGTH, MIN_SEQ_LENGTH)
    
    print(f": {len(ids)}")
    if len(ids) == 0:
        print("0")
        return


    print("K-mer count...")
    vectorizer = CountVectorizer(
        tokenizer=kmer_tokenizer, 
        token_pattern=None, 
        lowercase=False,
        min_df=2 
    )
    X_sparse = vectorizer.fit_transform(sequences)
    

    normalizer = Normalizer(norm='l2')
    X_normalized = normalizer.transform(X_sparse)



    try:
        X_dense = X_normalized.toarray()
    except MemoryError:
        print("❌ MemoryError")
        return

   
  
    pca = PCA(n_components=3, random_state=42)
    X_pca = pca.fit_transform(X_dense)
    
    print(f"PCA : PC1={pca.explained_variance_ratio_[0]:.2%}, "
          f"PC2={pca.explained_variance_ratio_[1]:.2%}, "
          f"PC3={pca.explained_variance_ratio_[2]:.2%}")


    df_result = pd.DataFrame({
        'ID': ids,
        'PC1': X_pca[:, 0],
        'PC2': X_pca[:, 1],
        'PC3': X_pca[:, 2]
    })
    
    csv_path = os.path.join(OUTPUT_DIR, "pca_coordinates.csv")
    df_result.to_csv(csv_path, index=False)
    with open(os.path.join(OUTPUT_DIR, "variance_ratio.txt"), "w") as f:
        f.write(f"{pca.explained_variance_ratio_[0]}\n")
        f.write(f"{pca.explained_variance_ratio_[1]}\n")
        f.write(f"{pca.explained_variance_ratio_[2]}\n")

if __name__ == "__main__":
    main()
