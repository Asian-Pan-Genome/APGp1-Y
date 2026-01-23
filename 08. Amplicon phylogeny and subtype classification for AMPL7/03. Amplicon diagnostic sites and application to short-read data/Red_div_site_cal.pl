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
		my $ratio_12=sprintf "%.4f", ($tmp_hash{"r1"}+$tmp_hash{"r2"})/($hash{"r1"}+$hash{"r2"}) if($hash{"r1"}+$hash{"r2"}>0);
		my $ratio_34=sprintf "%.4f", ($tmp_hash{"r3"}+$tmp_hash{"r4"})/($hash{"r3"}+$hash{"r4"}) if($hash{"r3"}+$hash{"r4"}>0);
		my $ratio1=sprintf "%.4f", $tmp_hash{"r1"}/$hash{"r1"} if($hash{"r1"}>0);
		my $ratio2=sprintf "%.4f", $tmp_hash{"r2"}/$hash{"r2"} if($hash{"r2"}>0);
		my $ratio3=sprintf "%.4f", $tmp_hash{"r3"}/$hash{"r3"} if($hash{"r3"}>0);
		my $ratio4=sprintf "%.4f", $tmp_hash{"r4"}/$hash{"r4"} if($hash{"r4"}>0);
		if(($ratio1-max($ratio2,$ratio3,$ratio4))>=$cutoff || ($ratio1-min($ratio2,$ratio3,$ratio4))<=-$cutoff){
			print OUT "$tmp[1]\t$tmp[3]\t$tmp[4]\tr1/r2/r3/r4:$ratio1/$ratio2/$ratio3/$ratio4\n";
		}
		elsif(($ratio2-max($ratio1,$ratio3,$ratio4))>=$cutoff || ($ratio2-min($ratio1,$ratio3,$ratio4))<=-$cutoff){
			print OUT "$tmp[1]\t$tmp[3]\t$tmp[4]\tr1/r2/r3/r4:$ratio1/$ratio2/$ratio3/$ratio4\n";
		}
		elsif(($ratio3-max($ratio1,$ratio2,$ratio4))>=$cutoff || ($ratio3-min($ratio1,$ratio2,$ratio4))<=-$cutoff){
			print OUT "$tmp[1]\t$tmp[3]\t$tmp[4]\tr1/r2/r3/r4:$ratio1/$ratio2/$ratio3/$ratio4\n";
		}
		elsif(($ratio4-max($ratio1,$ratio2,$ratio3))>=$cutoff || ($ratio4-min($ratio1,$ratio2,$ratio3))<=-$cutoff){
			print OUT "$tmp[1]\t$tmp[3]\t$tmp[4]\tr1/r2/r3/r4:$ratio1/$ratio2/$ratio3/$ratio4\n";
		}
		elsif(($ratio_12-$ratio_34)>=$cutoff || ($ratio_12-$ratio_34)<=-$cutoff){
			print OUT "$tmp[1]\t$tmp[3]\t$tmp[4]\tr1/r2/r3/r4:$ratio1/$ratio2/$ratio3/$ratio4\n";
		}
	}
}

