#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";

my ($type,$chr,$start,$end);
my %Colors;
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Colors{$tmp[3]}=$tmp[8];
	if($type eq ""){
		$type=$tmp[13];
		$chr=$tmp[10];
		$start=min($tmp[11],$tmp[12]);
		$end=max($tmp[11],$tmp[12]);
	}
	else{
		my $tmp_type=$tmp[13];
		my $tmp_chr=$tmp[10];
		my $tmp_start=min($tmp[11],$tmp[12]);
		my $tmp_end=max($tmp[11],$tmp[12]);
		if($tmp_type eq $type){
			if($tmp_chr eq $chr){
				$start=min($start,$end,$tmp_start,$tmp_end);
				$end=max($start,$end,$tmp_start,$tmp_end);
			}
			else{
				$start=$tmp_start;
				$end=$tmp_end;
			}
		}
		else{
			print OUT "$chr\t$start\t$end\t$type\t100\t\.\t$start\t$end\t$Colors{$type}\n";
			$type=$tmp[13];
			$chr=$tmp[10];
			$start=min($tmp[11],$tmp[12]);
			$end=max($tmp[11],$tmp[12]);
		}
	}
}
print OUT "$chr\t$start\t$end\t$type\t100\t\.\t$start\t$end\t$Colors{$type}\n";
