#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my (%hash1,%hash2);
while(<IN>){
	chomp;
	next if(/^pos/);
	my @tmp=split /\s+/,$_;
	$hash1{$tmp[0]}{$tmp[1]}=$tmp[-1];
	if($tmp[-1]>=0.05 && $tmp[-1]<=0.95){
		$hash2{$tmp[0]}=1;
	}
}

print OUT "pos\ttype\talt_frq\n";
foreach my $pos(sort {$a <=> $b} keys %hash1){
	next unless (exists $hash2{$pos});
	foreach my $type(sort {$a <=> $b} keys %{$hash1{$pos}}){
		print OUT "$pos\t$type\t$hash1{$pos}{$type}\n";
	}
}
