#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my %hash;
while(<IN1>){
	chomp;
	my @tmp=split /\t/,$_;
	for(my $i=8;$i<=$#tmp;$i++){
		next if($tmp[$i] eq "");
		$hash{$tmp[0]}{$tmp[$i]}=1;
	}
}
print OUT "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT";
foreach my $sam(sort {$a cmp $b} keys %hash){
	print OUT "\t$sam";
}
print OUT "\n";
while(<IN2>){
	chomp;
	my @tmp=split /\t/,$_;
	my $mut=$tmp[0];
	print OUT "1\t$tmp[1]\t$mut\t$tmp[2]\t$tmp[3]\t60\tPASS\t.\tGT";
	foreach my $sam(sort {$a cmp $b} keys %hash){
		if(exists $hash{$sam}{$tmp[0]}){
			print OUT "\t1|1";
		}
		else{
			print OUT "\t0|0";
		}
	}
	print OUT "\n";
}
