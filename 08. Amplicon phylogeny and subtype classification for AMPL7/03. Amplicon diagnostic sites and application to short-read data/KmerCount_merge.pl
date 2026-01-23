#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

my $dir="/share/home/zhanglab/user/liujing/LiuJing/03_pangenome/SV/AMP/Reconstruction/New_order/Re_name/Kmer_NGS/NGS_Del_validation/CPEGA_Kmercount";
open(OUT,">$ARGV[0]") || die "Can't open OUT!\n";
opendir(DIR,"$dir") || die "Can't open DIR!\n";
my $file;
my %hash;
while($file=readdir(DIR)){
	if($file=~ /(.*).site_kmer_counts.tsv\z/){
		my ($amp,$sam)=split /\_/,$1,2;
		open(IN,"$dir/$file") || die "Can't open IN!\n";
		while(<IN>){
			chomp;
			next if(/^Pos/);
			my @tmp=split /\s+/,$_;
			$hash{$amp}{$sam}{$tmp[0]}="$amp\t$tmp[0]\t$tmp[1]\t$tmp[2]\t$tmp[3]\t$tmp[4]\t$tmp[5]\t$tmp[7]\t$sam\t$tmp[6]\t$tmp[8]\t$tmp[9]";
		}
	}
}
print OUT "Amp\tPos\tRef_Allele\tAlt_Allele\tFrq_Str\tSubgroup\tRef_Kmer_Seq\tAlt_Kmer_Seq\tSample\tRef_Count\tAlt_Count\tControl_Depth\n";
foreach my $amp(sort {$a cmp $b} keys %hash){
	foreach my $sam(sort {$a cmp $b} keys %{$hash{$amp}}){
		foreach my $pos(sort {$a <=> $b} keys %{$hash{$amp}{$sam}}){
			print OUT "$hash{$amp}{$sam}{$pos}\n";
		}
	}
}
