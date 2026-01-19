#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
open(OUT1,">$ARGV[1]") || die "Can't open OUT1!\n";
open(OUT2,">$ARGV[2]") || die "Can't open OUT2!\n";
open(OUT3,">$ARGV[3]") || die "Can't open OUT3!\n";

my $block_count;
my %Species;
my %Blocks;
my %Ref;
my $judge;
while(<IN>){
	chomp;
	next if(/^#/);
	if(/^a/){
		$block_count++;
	}
	elsif(/^s/){
		my @tmp=split /\s+/,$_;
		if(!exists $Ref{$block_count}){
			$Ref{$block_count}=$tmp[-1];
			if(($tmp[2]>=2460000 && $tmp[2]<=8943627) || ($tmp[2]>=9828348 && $tmp[2]<=22269400)){
				$judge=1;
			}
			else{
				$judge=0;
			}
		}
		next if($judge==0);
		my $sample=(split /\./,$tmp[1])[0];
		$Species{$sample}=1;
		$Blocks{$block_count}{$sample}=$tmp[-1];
	}
}

my %Fasta;
my (%hash1,%hash2);
foreach my $num(sort {$a <=> $b} keys %Blocks){
	print "$num\n";
	foreach my $sam(sort {$a cmp $b} keys %Species){
		if(!exists $Blocks{$num}{$sam}){
			$Fasta{$sam}.="-" x length($Ref{$num});
		}
		else{
			$Fasta{$sam}.=$Blocks{$num}{$sam};
			$hash1{$sam}+=length($Ref{$num});
		}
		$hash2{$sam}+=length($Ref{$num});
	}
}

print OUT2 "sample\traw_length\timputed_length\n";
foreach my $sam(sort {$a cmp $b} keys %Fasta){
	print OUT1 ">$sam\n$Fasta{$sam}\n";
	print OUT2 "$sam\t$hash1{$sam}\t$hash2{$sam}\n";
}

my $start=1;
foreach my $num(sort {$a <=> $b} keys %Ref){
	my $end=$start+length($Ref{$num})-1;
	print OUT3 "DNA, block$num = $start\-$end\n";
	$start=$end+1;
}
