#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
my $cutoff=$ARGV[1];
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my @header;
my %hash;
while(<IN>){
	chomp;
	if(/^#/){
		@header=split /\s+/,$_;
		for(my $i=9;$i<=$#header;$i++){
			my $type=(split /\./,$header[$i])[1];
			$hash{$type}++;
		}
	}
	else{
		my @tmp=split /\s+/,$_;
		my %tmp_hash;
		for(my $i=9;$i<=$#header;$i++){
			my $type=(split /\./,$header[$i])[1];
			if($tmp[$i]==1){
				$tmp_hash{$type}++;
			}
		}
		my $ratio1=sprintf "%.4f", $tmp_hash{"ga1"}/$hash{"ga1"} if($hash{"ga1"}>0);
		my $ratio2=sprintf "%.4f", $tmp_hash{"ga2"}/$hash{"ga2"} if($hash{"ga2"}>0);
		if($ratio1-$ratio2>=$cutoff || $ratio1-$ratio2<=-$cutoff){
			print OUT "$tmp[1]\t$tmp[3]\t$tmp[4]\tgy1/gy2:$ratio1/$ratio2\n";
		}
		elsif($ratio2-$ratio1>=$cutoff || $ratio2-$ratio1<=-$cutoff){
			print OUT "$tmp[1]\t$tmp[3]\t$tmp[4]\tgy1/gy2:$ratio1/$ratio2\n";
		}
	}
}
