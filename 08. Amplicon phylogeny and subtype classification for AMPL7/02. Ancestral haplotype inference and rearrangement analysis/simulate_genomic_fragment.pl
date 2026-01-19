#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my %hash;
my $sample;
while(<IN>){
	chomp;
	if(/^\>/){
		s/\>//g;
		$sample=$_;
	}
	else{
		my @tmp=split /\s+/,$_;
		my $pos=0;
		for(my $i=0;$i<=$#tmp-1;$i++){
			my $strand="+";
			my $num=$tmp[$i];
			if($tmp[$i]=~ /\-/){
				$strand="-";
				$num=~ s/\-//g;
			}
			my $len=$num*100000;
			my $start=$pos+1;
			my $end=$pos+$len;
			$pos+=$len+10000;
			$hash{$num}{$sample}="$sample\.1:$start\-$end\ $strand";
		}
	}
}
foreach my $num(sort {$a <=> $b} keys %hash){
	print OUT ">$num\n";
	foreach my $spe(sort {$a cmp $b} keys %{$hash{$num}}){
		print OUT "$hash{$num}{$spe}\n";
	}
	print OUT "\n";
}
