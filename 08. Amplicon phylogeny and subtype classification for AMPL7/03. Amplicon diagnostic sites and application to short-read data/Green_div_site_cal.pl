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
		my $ratio_1=sprintf "%.4f", $tmp_hash{"g1"}/$hash{"g1"} if($hash{"g1"}>0);
		my $ratio_23=sprintf "%.4f", ($tmp_hash{"g2"}+$tmp_hash{"g3"})/($hash{"g2"}+$hash{"g3"}) if($hash{"g2"}+$hash{"g3"}>0);
		my $ratio1=sprintf "%.4f", $tmp_hash{"g1"}/$hash{"g1"} if($hash{"g1"}>0);
		my $ratio2=sprintf "%.4f", $tmp_hash{"g2"}/$hash{"g2"} if($hash{"g2"}>0);
		my $ratio3=sprintf "%.4f", $tmp_hash{"g3"}/$hash{"g3"} if($hash{"g3"}>0);
		if(($ratio1-max($ratio2,$ratio3))>=$cutoff || ($ratio1-min($ratio2,$ratio3))<=-$cutoff){
			print OUT "$tmp[1]\t$tmp[3]\t$tmp[4]\tg1/g2/g3:$ratio1/$ratio2/$ratio3\n";
		}
		elsif(($ratio2-max($ratio1,$ratio3))>=$cutoff || ($ratio2-min($ratio1,$ratio3))<=-$cutoff){
			print OUT "$tmp[1]\t$tmp[3]\t$tmp[4]\tg1/g2/g3:$ratio1/$ratio2/$ratio3\n";
		}
		elsif(($ratio3-max($ratio1,$ratio2))>=$cutoff || ($ratio3-min($ratio1,$ratio2))<=-$cutoff){
			print OUT "$tmp[1]\t$tmp[3]\t$tmp[4]\tg1/g2/g3:$ratio1/$ratio2/$ratio3\n";
		}
		elsif(($ratio_1-$ratio_23)>=$cutoff || ($ratio_1-$ratio_23)<=-$cutoff){
			print OUT "$tmp[1]\t$tmp[3]\t$tmp[4]\tg1/g2/g3:$ratio1/$ratio2/$ratio3\n";
		}
	}
}
