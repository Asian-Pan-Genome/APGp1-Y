#!/usr/bin/env python3
"""
生成任意样本与CHM13的top 3最佳匹配，并包含type信息
使用方法: python3 generate_top3_matches_generic.py <mash_file> [sample_name]

输出格式：
第1列: sample reads的ID
第2,3,4列: top1,2,3匹配的CHM13 reads的ID
第5,6,7列: top1,2,3匹配的距离值
第8,9,10列: CHM13 reads的type信息
"""

import csv
import numpy as np
import sys
import os
import re

def load_type_mapping(bed_file):
    """
    从BED文件加载CHM13 reads的type信息
    返回字典: {filename: type}
    """
    type_mapping = {}

    with open(bed_file, 'r') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue

            parts = line.split('\t')
            if len(parts) >= 4:
                chrom = parts[0]
                start = parts[1]
                end = parts[2]
                read_type = parts[3]

                # 构建文件名格式: CHM13.HSAT3.10k.part_chr{chrom}__{start}-{end}.fa
                filename = f"CHM13.HSAT3.10k.part_{chrom}__{start}-{end}.fa"
                type_mapping[filename] = read_type

    return type_mapping

def parse_mash_file(filename):
    """
    解析mash文件
    返回: (sample_reads, chm13_reads, distance_matrix, sample_species)
    """
    with open(filename, 'r') as f:
        # 读取第一行（header）
        header_line = f.readline().strip()
        header_parts = header_line.split(',')

        # 提取CHM13 reads列表
        chm13_reads = []
        for part in header_parts[1:]:  # 从第2个部分开始
            part = part.strip()
            if part and not part.startswith('kmer-length'):
                chm13_reads.append(part)

        # 读取距离数据
        sample_reads = []
        distance_matrix = []

        for line in f:
            line = line.strip()
            if not line:
                continue

            parts = line.split(',')
            sample_read = parts[0].strip()
            distances = []

            for x in parts[1:]:
                x = x.strip()
                if x:
                    try:
                        distances.append(float(x))
                    except ValueError:
                        continue

            # 确保距离数量和CHM13 reads数量匹配
            if len(distances) >= len(chm13_reads):
                distances = distances[:len(chm13_reads)]

            sample_reads.append(sample_read)
            distance_matrix.append(distances)

        # 从文件名推断样本物种
        base_name = os.path.basename(filename)
        if '.' in base_name:
            sample_species = base_name.split('.')[0]
        else:
            sample_species = "Sample"

    return sample_reads, chm13_reads, distance_matrix, sample_species

def find_top3_matches(sample_reads, chm13_reads, distance_matrix, type_mapping):
    """
    为每个sample read找到top 3最近的CHM13 read
    """
    results = []

    for i, sample_read in enumerate(sample_reads):
        distances = distance_matrix[i]

        # 找到前3个最小距离的索引和值
        indexed_distances = [(dist, idx) for idx, dist in enumerate(distances)]
        indexed_distances.sort()  # 按距离排序

        top_matches = []
        for j in range(min(3, len(indexed_distances))):
            distance, idx = indexed_distances[j]
            chm13_read = chm13_reads[idx]
            chm13_type = type_mapping.get(chm13_read, "Unknown")

            top_matches.append({
                'read': chm13_read,
                'distance': distance,
                'type': chm13_type,
                'index': idx
            })

        # 如果不足3个，用空值填充
        while len(top_matches) < 3:
            top_matches.append({
                'read': '',
                'distance': '',
                'type': '',
                'index': -1
            })

        results.append({
            'sample_read': sample_read,
            'top_matches': top_matches
        })

    return results

def generate_output_file(results, output_file, sample_species):
    """
    生成要求的输出格式
    """
    with open(output_file, 'w') as f:
        # 写入header
        header = ["{}_read".format(sample_species),
                 "top1_CHM13", "top2_CHM13", "top3_CHM13",
                 "top1_distance", "top2_distance", "top3_distance",
                 "top1_type", "top2_type", "top3_type"]
        f.write("\t".join(header) + "\n")

        # 写入数据
        for result in results:
            sample_read = result['sample_read']
            matches = result['top_matches']

            row = [sample_read]

            # 添加top 3的CHM13 reads
            for match in matches:
                row.append(match['read'])

            # 添加top 3的距离
            for match in matches:
                if match['distance'] != '':
                    row.append(f"{match['distance']:.6f}")
                else:
                    row.append('')

            # 添加top 3的type
            for match in matches:
                row.append(match['type'])

            f.write("\t".join(row) + "\n")

def generate_summary_report(results, stats_file, sample_species, mash_file):
    """
    生成统计摘要
    """
    with open(stats_file, 'w') as f:
        f.write(f"# {sample_species} vs CHM13 Top 3 匹配统计摘要\n")
        f.write(f"# 输入文件: {mash_file}\n\n")

        # 统计每种type在前3匹配中出现的次数
        type_counts = {}
        distance_stats = {'top1': [], 'top2': [], 'top3': []}

        for result in results:
            matches = result['top_matches']
            for i, match in enumerate(matches):
                if match['distance']:
                    distance_stats[f'top{i+1}'].append(match['distance'])
                    if match['type'] and match['type'] != "Unknown":
                        type_counts[match['type']] = type_counts.get(match['type'], 0) + 1

        f.write(f"总{sample_species} reads数量: {len(results)}\n\n")

        # 距离统计
        for position in ['top1', 'top2', 'top3']:
            distances = distance_stats[position]
            if distances:
                f.write(f"{position.upper()} 距离统计:\n")
                f.write(f"  平均值: {np.mean(distances):.6f}\n")
                f.write(f"  最小值: {min(distances):.6f}\n")
                f.write(f"  最大值: {max(distances):.6f}\n")
                f.write(f"  中位数: {np.median(distances):.6f}\n\n")

        # Type分布
        f.write("CHM13 reads Type分布（在前3匹配中）:\n")
        for read_type, count in sorted(type_counts.items()):
            percentage = count / sum(type_counts.values()) * 100
            f.write(f"  {read_type}: {count} ({percentage:.2f}%)\n")

def simplify_output(input_file, output_file, sample_species):
    """
    简化输出，提取short names
    """
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        # 读取header
        header = infile.readline().strip()
        outfile.write(header + "\n")

        # 处理数据行
        for line in infile:
            line = line.strip()
            if not line:
                continue

            parts = line.split('\t')
            if len(parts) < 10:
                continue

            # 简化sample read名称
            pattern = r'\.HSAT3\.10k\.part_'
            sample_simple = re.sub(pattern, '.', parts[0])
            if sample_simple.startswith('CHM13.'):
                sample_simple = sample_simple.replace('CHM13.HSAT3.10k.part_', 'CHM13.')
            elif '.' in sample_simple and not sample_simple.startswith(sample_species + '.'):
                sample_simple = f"{sample_species}.{sample_simple}"

            # 简化CHM13 read名称
            chm13_simple = []
            for i in range(1, 4):
                if parts[i]:
                    chm13_simple.append(parts[i].replace('CHM13.HSAT3.10k.part_', 'CHM13.'))
                else:
                    chm13_simple.append('')

            # 距离值保持不变
            distances = parts[4:7]

            # Type保持不变
            types = parts[7:10]

            # 重新组合行
            new_row = [sample_simple] + chm13_simple + distances + types
            outfile.write("\t".join(new_row) + "\n")

def main():
    # 参数处理
    if len(sys.argv) < 2:
        print("使用方法: python3 generate_top3_matches_generic.py <mash_file> [sample_name]")
        print("示例: python3 generate_top3_matches_generic.py Gor.HSAT3.Kmer9.common_tab.mash")
        print("示例: python3 generate_top3_matches_generic.py Gor.HSAT3.Kmer9.common_tab.mash Gorilla")
        sys.exit(1)

    mash_file = sys.argv[1]
    sample_name = sys.argv[2] if len(sys.argv) > 2 else None

    # 检查文件是否存在
    if not os.path.exists(mash_file):
        print(f"错误: 文件 {mash_file} 不存在")
        sys.exit(1)

    bed_file = "CHM13.HSAT3.10k.type.bed"
    if not os.path.exists(bed_file):
        print(f"错误: BED文件 {bed_file} 不存在")
        sys.exit(1)

    print("开始处理...")
    print(f"输入文件: {mash_file}")

    # 从文件名推断样本物种
    if not sample_name:
        base_name = os.path.basename(mash_file)
        sample_name = base_name.split('.')[0]

    # 加载type信息
    print("加载CHM13 type信息...")
    type_mapping = load_type_mapping(bed_file)
    print(f"加载了 {len(type_mapping)} 个CHM13 reads的type信息")

    # 解析mash文件
    print(f"解析{sample_name}的mash文件...")
    sample_reads, chm13_reads, distance_matrix, detected_species = parse_mash_file(mash_file)

    # 使用提供的名称或检测到的名称
    species_name = sample_name if sample_name else detected_species

    print(f"解析完成:")
    print(f"  - {species_name} reads: {len(sample_reads)}")
    print(f"  - CHM13 reads: {len(chm13_reads)}")
    print(f"  - 距离矩阵: {len(distance_matrix)} x {len(distance_matrix[0]) if distance_matrix else 0}")

    # 查找top 3匹配
    print(f"\n查找{species_name}的top 3匹配...")
    results = find_top3_matches(sample_reads, chm13_reads, distance_matrix, type_mapping)

    # 生成输出文件
    base_output_name = f"{species_name}_top3_CHM13_matches"
    output_file = f"{base_output_name}.tsv"
    generate_output_file(results, output_file, species_name)
    print(f"结果已写入: {output_file}")

    # 生成简化输出
    simplified_file = f"{base_output_name}_simplified.tsv"
    simplify_output(output_file, simplified_file, species_name)
    print(f"简化结果已写入: {simplified_file}")

    # 生成统计报告
    stats_file = f"{species_name}_top3_statistics.txt"
    generate_summary_report(results, stats_file, species_name, mash_file)
    print(f"统计报告已写入: {stats_file}")

    # 显示前3个结果作为示例
    print(f"\n{species_name}前3个结果示例:")
    print("{:<50} {:<35} {:<10} {:<8}".format(
        f"{species_name} Read", "Top1 CHM13", "Distance", "Type"))
    print("-" * 105)

    for result in results[:3]:
        sample_simple = result['sample_read'].replace(f'{species_name}.HSAT3.10k.part_', species_name + '.')
        top1 = result['top_matches'][0]

        print("{:<50} {:<35} {:<10.6f} {:<8}".format(
            sample_simple[:47] + "..." if len(sample_simple) > 47 else sample_simple,
            top1['read'].replace('CHM13.HSAT3.10k.part_', 'CHM13.')[:32] + "..." if len(top1['read']) > 35 else top1['read'].replace('CHM13.HSAT3.10k.part_', 'CHM13.'),
            top1['distance'],
            top1['type']
        ))

    print(f"\n处理完成! 共处理了 {len(results)} 个{species_name} reads")

if __name__ == "__main__":
    main()