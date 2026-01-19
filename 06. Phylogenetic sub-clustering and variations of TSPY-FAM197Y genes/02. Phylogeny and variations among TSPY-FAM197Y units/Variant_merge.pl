#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";##DEL
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";##INS
open(IN3,"$ARGV[2]") || die "Can't open IN3!\n";##SNP
open(OUT,">$ARGV[3]") || die "Can't open OUT!\n";

my %hash;
my %Allele_frq;
while(<IN1>){
	chomp;
	next if(/^#/);
	my @tmp=split /\s+/,$_;
	if($tmp[4]=~ /\,/){
		$tmp[4]=(split /\,/,$tmp[4])[0];
		for(my $i=9;$i<=$#tmp;$i++){
			if($tmp[$i]>1){
				$tmp[$i]=1;
			}
		}
		my @arr1=split /\,/,(split /\=/,(split /\;/,$tmp[7])[0])[1];
		my @arr2=split /\,/,(split /\=/,(split /\;/,$tmp[7])[1])[1];
		my $AN=(split /\=/,(split /\;/,$tmp[7])[2])[1];
		my $AC;
		my $AF;
		for(my $i=0;$i<=$#arr1;$i++){
			$AC+=$arr1[$i];
			$AF+=$arr2[$i];
		}
		$tmp[7]="AC\=$AC\;AF\=$AF\;AN\=$AN";
		$Allele_frq{$tmp[1]}=$AC;
		$hash{$tmp[1]}=join("\t",@tmp);
	}
	else{
		for(my $i=9;$i<=$#tmp;$i++){
			if($tmp[$i]>1){
				$tmp[$i]=1;
			}
		}
		$hash{$tmp[1]}=join("\t",@tmp);
		$Allele_frq{$tmp[1]}=(split /\=/,(split /\;/,$tmp[7])[0])[1];
	}
}

while(<IN2>){
	chomp;
	next if(/^#/);
	my @tmp=split /\s+/,$_;
	if($tmp[4]=~ /\,/){
		$tmp[4]=(split /\,/,$tmp[4])[0];
		for(my $i=9;$i<=$#tmp;$i++){
			if($tmp[$i]>1){
				$tmp[$i]=1;
			}
		}
		my @arr1=split /\,/,(split /\=/,(split /\;/,$tmp[7])[0])[1];
		my @arr2=split /\,/,(split /\=/,(split /\;/,$tmp[7])[1])[1];
		my $AN=(split /\=/,(split /\;/,$tmp[7])[2])[1];
		my $AC;
		my $AF;
		for(my $i=0;$i<=$#arr1;$i++){
			$AC+=$arr1[$i];
			$AF+=$arr2[$i];
		}
		$tmp[7]="AC\=$AC\;AF\=$AF\;AN\=$AN";
		if(!exists $hash{$tmp[1]}){
			$hash{$tmp[1]}=join("\t",@tmp);
		}
		else{
			if($AC>$Allele_frq{$tmp[1]}){
				$Allele_frq{$tmp[1]}=$AC;
				$hash{$tmp[1]}=join("\t",@tmp);
			}
		}
	}
	else{
		for(my $i=9;$i<=$#tmp;$i++){
			if($tmp[$i]>1){
				$tmp[$i]=1;
			}
		}
		if(!exists $hash{$tmp[1]}){
			$hash{$tmp[1]}=join("\t",@tmp);
		}
		else{
			my $frq=(split /\=/,(split /\;/,$tmp[7])[0])[1];
			if($frq>$Allele_frq{$tmp[1]}){
				$Allele_frq{$tmp[1]}=$frq;
				$hash{$tmp[1]}=join("\t",@tmp);
			}
		}
	}
}

while(<IN3>){
	chomp;
	if(/^#/){
		print OUT "$_\n";
	}
	else{
		my @tmp=split /\s+/,$_;
		if($tmp[4]=~ /\,/){
			$tmp[4]=(split /\,/,$tmp[4])[0];
			for(my $i=9;$i<=$#tmp;$i++){
				if($tmp[$i]>1){
					$tmp[$i]=1;
				}
			}
			my @arr1=split /\,/,(split /\=/,(split /\;/,$tmp[7])[0])[1];
			my @arr2=split /\,/,(split /\=/,(split /\;/,$tmp[7])[1])[1];
			my $AN=(split /\=/,(split /\;/,$tmp[7])[2])[1];
			my $AC;
			my $AF;
			for(my $i=0;$i<=$#arr1;$i++){
				$AC+=$arr1[$i];
				$AF+=$arr2[$i];
			}
			$tmp[7]="AC\=$AC\;AF\=$AF\;AN\=$AN";
			if(!exists $hash{$tmp[1]}){
				$hash{$tmp[1]}=join("\t",@tmp);
			}
			else{
				if($AC>$Allele_frq{$tmp[1]}){
					$Allele_frq{$tmp[1]}=$AC;
					$hash{$tmp[1]}=join("\t",@tmp);
				}
			}
		}
		else{
			for(my $i=9;$i<=$#tmp;$i++){
			if($tmp[$i]>1){
				$tmp[$i]=1;
			}
		}
			if(!exists $hash{$tmp[1]}){
				$hash{$tmp[1]}=join("\t",@tmp);
			}
			else{
				my $frq=(split /\=/,(split /\;/,$tmp[7])[0])[1];
				if($frq>$Allele_frq{$tmp[1]}){
					$Allele_frq{$tmp[1]}=$frq;
					$hash{$tmp[1]}=join("\t",@tmp);
				}
			}
		}
	}
}

foreach my $pos(sort {$a <=> $b} keys %hash){
	print OUT "$hash{$pos}\n";
}
