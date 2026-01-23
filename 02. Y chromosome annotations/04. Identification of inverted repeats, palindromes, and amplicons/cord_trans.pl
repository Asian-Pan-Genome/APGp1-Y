#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[1].cord_trans") || die "Can't open OUT!\n";

my $pos;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$pos=$tmp[1]-1;
}

print OUT "chr\tstart\tend\tclass\n";
while(<IN2>){
	chomp;
	if(/start/){
		print OUT "$_\n";
	}
	else{
		my @tmp=split /\s+/,$_;
		my $start=$tmp[1]-$pos;
		my $end=$tmp[2]-$pos;
		print OUT "$tmp[0]\t$start\t$end\t$tmp[3]\n";
	}
}

