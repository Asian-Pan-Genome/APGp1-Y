#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[0].maunally") || die "Can't open OUT!\n";

while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	my ($start,$end)=split /\-/,(split /\(/,(split /\:/,$tmp[3])[-1])[0];
	my $len1=$tmp[2]-$tmp[1];
	my $len2=$end-$start;
	print OUT "$_\t$len1\t$len2\n";
}

