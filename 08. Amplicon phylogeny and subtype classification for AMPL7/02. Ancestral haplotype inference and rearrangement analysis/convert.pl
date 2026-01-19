#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my (%hash1,%hash2);
my $count;
while(<IN>){
	chomp;
	if(/^\d+/){
		print OUT "$_\n";
	}
	else{
		my @tmp=split /\s+/,$_;
		$count++;
		$hash1{$count}=$tmp[0];
		$hash2{$count}{$count}=0;
		next unless($#tmp>=1);
		for(my $i=1;$i<=$#tmp;$i++){
			#next if($tmp[$i] eq "");
			$hash2{$count}{$i}=$tmp[$i];
			$hash2{$i}{$count}=$tmp[$i];
		}
	}
}

foreach my $i(sort {$a <=> $b} keys %hash1){
	print OUT "$hash1{$i}";
	foreach my $j(sort {$a <=> $b} keys %hash1){
		if($i==$j){
			print OUT " 0";
		}
		else{
			print OUT " $hash2{$i}{$j}";
		}
	}
	print OUT "\n";
}
