#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my %hash;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$hash{$tmp[1]}=$tmp[2];
}

while(<IN2>){
	chomp;
	if(/^#/){
		print OUT "$_\n";
	}
	else{
		my @tmp=split /\s+/,$_,3;
		my $judge=0;
		foreach my $pos1(sort {$a <=> $b} keys %hash){
			my $pos2=$hash{$pos1};
			if($tmp[1]>=$pos1 && $tmp[1]<=$pos2){
				$judge=1;
				last;
			}
		}
		if($judge==1){
			print OUT "$_\n";
		}
	}
}