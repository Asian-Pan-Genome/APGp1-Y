#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
my $maf=$ARGV[1];
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

while(<IN>){
	chomp;
	if(/^#/){
		print OUT "$_\n";
	}
	else{
	my @tmp=split /\s+/,$_;
		my $af=(split /\=/,(split /\;/,$tmp[7])[1])[1];
		if($af>=0.1 && $af<=0.9){
			print OUT "$_\n";
		}
	}
}

