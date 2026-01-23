#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
my $total_num=$ARGV[1];
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my (%SNP1,%SNP2);
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	$SNP1{$tmp[0]}{$tmp[1]}=$tmp[2];
	$SNP2{$tmp[0]}{$tmp[2]}++;
}

my %SNP;
foreach my $pos(sort {$a <=> $b} keys %SNP2){
	foreach my $type(sort {$a cmp $b} keys %{$SNP2{$pos}}){
		if($SNP2{$pos}{$type}>=$total_num*0.05 && $SNP2{$pos}{$type}<=$total_num*0.95){
			$SNP{$pos}{$type}=1;
		}
	}
}

foreach my $pos(sort {$a <=> $b} keys %SNP1){
	foreach my $sam(sort {$a cmp $b} keys %{$SNP1{$pos}}){
		my $geno=$SNP1{$pos}{$sam};
		next unless(exists $SNP{$pos}{$geno});
		print OUT "$pos\t$sam\t$geno\n";
	}
}
