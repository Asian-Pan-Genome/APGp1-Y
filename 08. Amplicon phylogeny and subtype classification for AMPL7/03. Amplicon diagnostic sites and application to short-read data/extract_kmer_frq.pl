#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(IN3,"$ARGV[2]") || die "Can't open IN3!\n";
open(OUT,">$ARGV[3]") || die "Can't open OUT!\n";

my %DEL;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$DEL{$tmp[0]}=$tmp[-1];
}

my %Kmer;
while(<IN2>){
	chomp;
	next if(/^Amp/);
	my @tmp=split /\s+/,$_;
	$Kmer{$tmp[0]}{$tmp[1]}{$tmp[6]}=$tmp[7];
}

while(<IN3>){
	chomp;
	if(/^Amp/){
		print OUT "Amp\tPos\tRef\tAlt\tFrq_str\tSubgroup\tAllele\tRef_kmer\tAlt_kmer\tSample\tType\tRef_Count\tAlt_Count\tFrq\tDepth\n";
	}
	else{
		my @tmp=split /\s+/,$_;
		next unless(exists $DEL{$tmp[8]});
		foreach my $subgroup(sort {$a cmp $b} keys %{$Kmer{$tmp[0]}{$tmp[1]}}){
			my $allele=$Kmer{$tmp[0]}{$tmp[1]}{$subgroup};
			my $frq="NA";
			if($allele eq "Alt"){
				$frq=$tmp[-2]/($tmp[-3]+$tmp[-2]) if($tmp[-3]+$tmp[-2]>=5);
			}
			elsif($allele eq "Ref"){
				$frq=$tmp[-3]/($tmp[-3]+$tmp[-2]) if($tmp[-3]+$tmp[-2]>=5);
			}
			print OUT "$tmp[0]\t$tmp[1]\t$tmp[2]\t$tmp[3]\t$tmp[4]\t$subgroup\t$allele\t$tmp[6]\t$tmp[7]\t$tmp[8]\t$DEL{$tmp[8]}\t$tmp[9]\t$tmp[10]\t$frq\t$tmp[11]\n";
		}
	}
}
