#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my %Samples;
while(<IN1>){
	chomp;
	my $sam=(split /\//,$_)[-1];
	$sam=~ s/.fa//g;
	$Samples{$sam}=1;
}

my %Allele;
my %Variant;
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	$tmp[2]=uc($tmp[2]);
	$Allele{$tmp[0]}{$tmp[2]}++;
	$Variant{$tmp[0]}{$tmp[1]}=$tmp[2];
}

my $sam_num;
print OUT "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT";
foreach my $sam(sort {$a cmp $b} keys %Samples){
	$sam_num++;
	print OUT "\t$sam";
}
print OUT "\n";

foreach my $pos(sort {$a <=> $b} keys %Allele){
	my $ref_allele;
	my %alt_allele;
	my $alt;
	my ($AC,$AF);
	my %ALT_geno;
	my $ALT_count;
	foreach my $allele(sort {$a cmp $b} keys %{$Allele{$pos}}){
		$ALT_count++;
		$ref_allele=(split /\|/,$allele)[0];
		my $tmp_alt=(split /\|/,$allele)[1];
		$alt_allele{$tmp_alt}=$Allele{$pos}{$allele};
		$ALT_geno{$tmp_alt}=$ALT_count;
	}
	foreach my $key(sort {$alt_allele{$b} <=> $alt_allele{$a}} keys %alt_allele){
		if($alt eq ""){
			$alt=$key;
			$AC=$alt_allele{$key};
			$AF=$alt_allele{$key}/$sam_num if($sam_num>0);
		}
		else{
			$alt.=",$key";
			$AC.=","."$alt_allele{$key}";
			$AF.=",".($alt_allele{$key}/$sam_num) if($sam_num>0);
		}
	}
	print OUT "1\t$pos\t.\t$ref_allele\t$alt\t60\t.\tAC\=$AC;AF\=$AF;AN=$sam_num\tGT";
	foreach my $sam(sort {$a cmp $b} keys %Samples){
		my $geno="0";
		if(exists $Variant{$pos}{$sam}){
			my $tmp_alt=(split /\|/,$Variant{$pos}{$sam})[1];
			$geno=$ALT_geno{$tmp_alt};
		}
		print OUT "\t$geno";
	}
	print OUT "\n";
}
