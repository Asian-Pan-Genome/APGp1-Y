#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT1,">$ARGV[2]") || die "Can't open OUT1!\n";
open(OUT2,">$ARGV[3]") || die "Can't open OUT2!\n";
my %SNP;
my ($count1,$count2,$count3);
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	if(!exists $SNP{$tmp[0]}){
		$count1++;
	}
	$SNP{$tmp[0]}="$tmp[0]\t$tmp[2]";
}
my %INDEl;
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	if(!exists $INDEl{$tmp[0]}){
		$count2++;
		$INDEl{$tmp[0]}=1;
		if(exists $SNP{$tmp[0]}){
			$count3++;
			print OUT2 "$tmp[0]\t$tmp[2]\t$SNP{$tmp[0]}\n";
		}
	}
}
print OUT1 "SNP: $count1\nINDEL: $count2\nBoth: $count3\n";
