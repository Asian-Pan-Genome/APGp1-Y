import pandas as pd
import matplotlib.pyplot as plt
import os


COORD_FILE = "PCA_core_Results/pca_coordinates.csv"
VAR_FILE = "PCA_core_Results/variance_ratio.txt"
CLASS_FILE = "Alu_class"

OUTPUT_PREFIX = "PCA_core_Plot" 


DEFAULT_TYPE = "Other"
DEFAULT_COLOR = "#d3d3d3"

def load_classification(file_path):
    
    if not os.path.exists(file_path):
        return {}
    try:
        df = pd.read_csv(file_path, sep='\s+', names=['ID', 'Type', 'Color'], header=None)
        return df.set_index('ID').to_dict(orient='index')
    except Exception as e:
        return {}

def draw_pca_scatter(df, x_col, y_col, x_label, y_label, output_filename):
    plt.figure(figsize=(10, 8))

    unique_types = sorted(df['Type'].unique())
    if DEFAULT_TYPE in unique_types:
        unique_types.remove(DEFAULT_TYPE)
        unique_types.insert(0, DEFAULT_TYPE)

    for t in unique_types:
        subset = df[df['Type'] == t]
        
        # 样式设置
        if t == DEFAULT_TYPE:
            alpha = 0.3
            size = 15
            zorder = 1
            edge = 'none'
            label_text = "Other"
        else:
            alpha = 0.9
            size = 70
            zorder = 10
            edge = 'none'
            label_text = t

        color = subset['Color'].iloc[0]

        plt.scatter(
            subset[x_col], 
            subset[y_col], 
            c=color, 
            label=label_text, 
            s=size, 
            alpha=alpha, 
            edgecolors=edge,
            linewidth=0.5,
            zorder=zorder
        )

    plt.xlabel(x_label)
    plt.ylabel(y_label)
    plt.title(f'PCA Projection ({x_col} vs {y_col})')
    

    plt.legend(bbox_to_anchor=(1.02, 1), loc='upper left', borderaxespad=0.)
    plt.tight_layout()

    plt.savefig(output_filename, dpi=300)
    plt.close()

def main():

    if not os.path.exists(COORD_FILE):
        return
    

    df = pd.read_csv(COORD_FILE)
    df['ID'] = df['ID'].astype(str)


    pc1_lab, pc2_lab, pc3_lab = "PC1", "PC2", "PC3"
    if os.path.exists(VAR_FILE):
        with open(VAR_FILE, 'r') as f:
            lines = f.readlines()
            if len(lines) >= 2:
                v1 = float(lines[0].strip())
                v2 = float(lines[1].strip())
                pc1_lab = f"PC1 ({v1:.2%} var)"
                pc2_lab = f"PC2 ({v2:.2%} var)"
            if len(lines) >= 3:
                v3 = float(lines[2].strip())
                pc3_lab = f"PC3 ({v3:.2%} var)"


    meta_map = load_classification(CLASS_FILE)
    
    df['Type'] = df['ID'].apply(lambda x: meta_map.get(x, {}).get('Type', DEFAULT_TYPE))
    df['Color'] = df['ID'].apply(lambda x: meta_map.get(x, {}).get('Color', DEFAULT_COLOR))

    print("-" * 30)
    print(df['Type'].value_counts())
    print("-" * 30)

    
    draw_pca_scatter(
        df, 
        x_col='PC1', 
        y_col='PC2', 
        x_label=pc1_lab, 
        y_label=pc2_lab, 
        output_filename=f"{OUTPUT_PREFIX}_PC1_PC2.pdf"
    )

    if 'PC3' in df.columns:
        draw_pca_scatter(
            df, 
            x_col='PC1', 
            y_col='PC3', 
            x_label=pc1_lab, 
            y_label=pc3_lab, 
            output_filename=f"{OUTPUT_PREFIX}_PC1_PC3.pdf"
        )
    else:
        print("no PC3")

if __name__ == "__main__":
    main()
