import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import argparse
import matplotlib.colors as mcolors


parser = argparse.ArgumentParser(description='Plot the difference between two heatmap files as a line plot.')
parser.add_argument('input_file1', type=str, help='Path to the first input file (heatmap data).')
parser.add_argument('input_file2', type=str, help='Path to the second input file (heatmap data).')
parser.add_argument('output_file', type=str, help='Path to save the output plot.')
args = parser.parse_args()


def read_heatmap_data(file_path):
    df = pd.read_csv(file_path, sep='\t')
    return df['Heatmap_Value'].values


heatmap_values1 = read_heatmap_data(args.input_file1)
heatmap_values2 = read_heatmap_data(args.input_file2)


if len(heatmap_values1) != len(heatmap_values2):
    raise ValueError("The lengths of the two heatmap files do not match!")


def normalize(values):
    v_max = max(abs(values.max()), abs(values.min()))
    norm = mcolors.Normalize(vmin=-v_max, vmax=v_max)
    return norm(values)

heatmap_values1_normalized = normalize(heatmap_values1)
heatmap_values2_normalized = normalize(heatmap_values2)


difference = heatmap_values1_normalized - heatmap_values2_normalized


positions = np.arange(1, len(difference) + 1)


plt.figure(figsize=(10, 6))
plt.plot(positions, difference, color='black', linestyle='-', linewidth=2, label='Difference')


plt.axvline(x=85, color='red', linestyle='--', linewidth=2, label='Position 85')


plt.ylim(-0.12, 0.1)


plt.title('Difference Between Two Heatmaps', fontsize=16)
plt.xlabel('Position', fontsize=14)
plt.ylabel('Normalized Difference', fontsize=14)



plt.legend()

plt.savefig(args.output_file, dpi=300, bbox_inches='tight')
print(f"\nLine plot saved to: {args.output_file}")


#plt.show()
