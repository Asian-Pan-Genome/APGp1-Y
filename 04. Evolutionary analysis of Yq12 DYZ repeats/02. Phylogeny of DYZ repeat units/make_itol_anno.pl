#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT1,">$ARGV[2]") || die "Can't open OUT1!\n";
open(OUT2,">$ARGV[3]") || die "Can't open OUT2!\n";

my %Col;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Col{$tmp[0]}=$tmp[1];
}

print OUT1 "DATASET_SYMBOL\nSEPARATOR\tTAB\nDATASET_LABEL\texample\tsymbols\nCOLOR\t#ff0000\nDATA\n";
print OUT2 "DATASET_COLORSTRIP\nSEPARATOR\tTAB\nDATASET_LABEL\tType\nCOLOR\t#ff0000\nDATA\n";
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	print OUT1 "$tmp[0]\t2\t2\t$Col{$tmp[2]}\t1\t1\n";
	print OUT2 "$tmp[0]\t$Col{$tmp[1]}\n";
}

