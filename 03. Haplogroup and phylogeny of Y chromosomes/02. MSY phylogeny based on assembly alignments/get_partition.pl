#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my %Regions;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Regions{$tmp[1]}="$tmp[2]\t$tmp[3]";
}

my (%Block,%Partition);
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	my $start=$tmp[1];
	my $length=$tmp[2];
	my $end=$start+$length;
	my ($type,$overlap);
	foreach my $pos1(sort {$a <=> $b} keys %Regions){
		my ($pos2,$reg)=split /\t/,$Regions{$pos1};
		if($pos1<=$end && $pos2>=$start){
			my $tmp_overlap=min($pos2,$end)-max($pos1,$start);
			if($tmp_overlap>$overlap){
				$overlap=$tmp_overlap;
				$type=$reg;
			}
		}
	}
	$Partition{$type}+=$length;
}

my $index=0;
foreach my $pos1(sort {$a <=> $b} keys %Regions){
	my ($pos2,$type)=split /\t/,$Regions{$pos1};
	if(exists $Partition{$type}){
		my $start=$index+1;
		my $end=$start+$Partition{$type}-1;
		$index=$end;
		print OUT "DNA, $type = $start\-$end\n";
	}
}
