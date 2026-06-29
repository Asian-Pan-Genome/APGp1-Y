#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;
use List::Util qw(max min);

if (@ARGV < 4) {
	die "Usage: perl $0 <gap_info.txt> <paf_dir> <chm13_based.vcf/vcf.gz> <out_prefix>\n";
}

my ($gap_file, $paf_dir, $vcf_file, $out_prefix) = @ARGV;
my %sample_names;
open(my $in_gap, "<", $gap_file) or die "Cannot open $gap_file: $!\n";
while (<$in_gap>) {
	chomp;
	#s/-CHA//g;
	next if /^\s*$/;
	my ($sample_chr) = split /\s+/;
	my $sample_id = (split /#/, $sample_chr)[0];
	$sample_names{$sample_id} = 1;
}
close $in_gap;

my %mapped_gaps_on_ref; 
my %gap_summary;
my $mapped_count = 0;

foreach my $sample (keys %sample_names) {
	my $paf_path = "$paf_dir/$sample.gaps.paf";
	if (!-e $paf_path) {
		warn "  Cannot find PAF file: $paf_path\n";
		next;
	}
	$sample=~ s/-CHA//g;
	my %query_hits;
	open(my $in_paf, "<", $paf_path) or die "Cannot open $paf_path: $!\n";
	while (<$in_paf>) {
		chomp;
		s/-CHA//g;
		s/CHM13_/chr/g;
		my @cols = split /\t/;
		my $q_name = $cols[0];
		my $q_len  = $cols[1];
		push @{$query_hits{$q_name}}, {
			q_len   => $q_len,
			q_start => $cols[2],
			q_end   => $cols[3],
			strand  => $cols[4],
			t_name  => $cols[5],
			t_start => $cols[7],
			t_end   => $cols[8]
		};
	}
	close $in_paf;
	foreach my $q_name (keys %query_hits) {
		my $hits = $query_hits{$q_name};
		my $q_len = $hits->[0]->{q_len};
		my $best_left_hit;  my $max_left_ovl = 0;
		my $best_right_hit; my $max_right_ovl = 0;
		foreach my $hit (@$hits) {
			my $left_ovl = max(0, min($hit->{q_end}, 1000) - max($hit->{q_start}, 0));
			if ($left_ovl > $max_left_ovl) {
				$max_left_ovl = $left_ovl;
				$best_left_hit = $hit;
			}
			my $right_ovl = max(0, min($hit->{q_end}, $q_len) - max($hit->{q_start}, $q_len - 1000));
			if ($right_ovl > $max_right_ovl) {
				$max_right_ovl = $right_ovl;
				$best_right_hit = $hit;
			}
		}
		if ($max_left_ovl < 100 || $max_right_ovl < 100) {
			next;
		}
		my $ref_chr_left = $best_left_hit->{t_name};
		my $start_left   = $best_left_hit->{t_start} + 1; # 转为 1-based
		my $end_left	 = $best_left_hit->{t_end};
		my $ref_chr_right = $best_right_hit->{t_name};
		my $start_right   = $best_right_hit->{t_start} + 1;
		my $end_right	 = $best_right_hit->{t_end};
		if ($best_left_hit == $best_right_hit) {
			my $coord_str = "$ref_chr_left:$start_left-$end_left";
			$gap_summary{$q_name} = { sample => $sample, coords => $coord_str, count => 0 };
			push @{$mapped_gaps_on_ref{$ref_chr_left}{$sample}}, {
				start => $start_left,
				end   => $end_left,
				orig  => $q_name
			};
		} else {
			next if $ref_chr_left ne $ref_chr_right; 
			next if $best_left_hit->{strand} ne $best_right_hit->{strand};
			my $coord_str = "$ref_chr_left:$start_left-$end_left/$ref_chr_right:$start_right-$end_right";
			$gap_summary{$q_name} = { sample => $sample, coords => $coord_str, count => 0 };
			push @{$mapped_gaps_on_ref{$ref_chr_left}{$sample}}, {
				start => $start_left,
				end   => $end_left,
				orig  => "$q_name\_LeftFlank"
			};
			push @{$mapped_gaps_on_ref{$ref_chr_right}{$sample}}, {
				start => $start_right,
				end   => $end_right,
				orig  => "$q_name\_RightFlank"
			};
		}
		$mapped_count++;
	}
}
my $vcf_fh;
if ($vcf_file =~ /\.gz$/) {
	open($vcf_fh, "zcat $vcf_file |") or die "Cannot open $vcf_file: $!\n";
} else {
	open($vcf_fh, "<", $vcf_file) or die "Cannot open $vcf_file: $!\n";
}

my $out_detail = "$out_prefix.affected_variants.txt";
my $out_stat   = "$out_prefix.summary_stats.txt";
open(my $out_fh, ">", $out_detail) or die $!;
print $out_fh "Ref_Chr\tRef_Pos\tRef_REF\tRef_ALT\tSample\tGenotype\tMapped_Region_Start\tMapped_Region_End\tOrig_Query_Name\n";
my %vcf_sample_cols;
while (<$vcf_fh>) {
	chomp;
	next if /^##/;
	if (/^#CHROM/) {
		my @header = split /\t/;
		for (my $i = 9; $i < @header; $i++) {
			$vcf_sample_cols{$header[$i]} = $i;
		}
		next;
	}
	my @cols = split /\t/;
	my $chr = $cols[0];
	#$chr = "CHM13_Y" if $chr eq "chrY";
	my $pos = $cols[1];
	my $ref = $cols[3];
	my $alt = $cols[4];
	next unless exists $mapped_gaps_on_ref{$chr};
	foreach my $sample (keys %{$mapped_gaps_on_ref{$chr}}) {
		next unless exists $vcf_sample_cols{$sample}; 
		my $col_idx = $vcf_sample_cols{$sample};
		my ($gt) = split /:/, $cols[$col_idx];
		if ($gt =~ /[1-9]/) {
			my %counted_for_gap;
			foreach my $gap (@{$mapped_gaps_on_ref{$chr}{$sample}}) {
				if ($pos >= $gap->{start} && $pos <= $gap->{end}) {
					my $base_q = $gap->{orig};
					$base_q =~ s/\_(Left|Right)Flank$//;
					unless (exists $counted_for_gap{$base_q}) {
						print $out_fh "$chr\t$pos\t$ref\t$alt\t$sample\t$gt\t$gap->{start}\t$gap->{end}\t$gap->{orig}\n";
						$gap_summary{$base_q}{count}++;
						$counted_for_gap{$base_q} = 1;
					}
				}
			}
		}
	}
}
close $vcf_fh;
close $out_fh;
open(my $stat_fh, ">", $out_stat) or die $!;
print $stat_fh "Gap_Query_Name\tSample_ID\tMapped_Coordinates\tAffected_Variants_Count\n";
foreach my $q_name (sort keys %gap_summary) {
	my $sample = $gap_summary{$q_name}{sample};
	my $coords = $gap_summary{$q_name}{coords};
	my $count  = $gap_summary{$q_name}{count};
	
	print $stat_fh "$q_name\t$sample\t$coords\t$count\n";
}
close $stat_fh;

print "Done！\n";
print "  -> Variant summary: $out_detail\n";
print "  -> Gap information: $out_stat\n";
