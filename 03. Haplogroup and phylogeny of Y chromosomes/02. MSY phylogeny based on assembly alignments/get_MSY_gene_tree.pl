#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";
my $dir="/share/home/zhanglab/user/liujing/LiuJing/02_haplogroup/Phylogeny/04_alignment/Blocks";
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	my $gene_tree=join("_",@tmp);
	my $tree_file="$dir\/$tmp[-1]\/$tmp[-1].treefile.reroot";
	if(-e $tree_file){
		open(INPUT,"$tree_file") || die "Can't open $gene_tree tree file!\n";
		while(<INPUT>){
			chomp;
			print OUT "$gene_tree\t$_\n";
		}
	}
}
