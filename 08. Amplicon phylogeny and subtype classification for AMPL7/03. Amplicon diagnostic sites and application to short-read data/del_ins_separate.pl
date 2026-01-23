#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT1,">$ARGV[1]") || die "Can't open OUT1!\n";
open(OUT2,">$ARGV[2]") || die "Can't open OUT2!\n";

while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	$tmp[2]=uc($tmp[2]);
	my ($ref,$alt)=split /\|/,$tmp[2];
	if(length($ref)<length($alt)){
		print OUT1 "$_\n";
	}
	else{
		print OUT2 "$_\n";
	}
}
