#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT1,">$ARGV[2]") || die "Can't open OUT1!\n";
open(OUT2,">$ARGV[3]") || die "Can't open OUT2!\n";

my (%hash1,%hash2,%hash3);
my %Hap;
while(<IN1>){
	chomp;
	my @tmp=split /\t/,$_;
	$hash1{$tmp[6]}++;
	$hash2{$tmp[6]}{$tmp[4]}++;
	$Hap{$tmp[4]}=1;
	for(my $i=8;$i<=$#tmp;$i++){
		next if($tmp[$i] eq "");
		$hash3{$tmp[6]}{$tmp[$i]}=1;
	}
}
print OUT1 "name\thaplotype\tnum";
foreach my $key(sort {$a cmp $b} keys %Hap){
	print OUT1 "\t$key";
}
print OUT1 "\n";
my $count;
foreach my $hap(sort {$hash1{$b} <=> $hash1{$a}} keys %hash1){
	$count++;
	print OUT1 "hap$count\t$hap\t$hash1{$hap}";
	foreach my $key(sort {$a cmp $b} keys %Hap){
		my $num=0;
		if(exists $hash2{$hap}{$key}){
			$num=$hash2{$hap}{$key};
		}
		print OUT1 "\t$num";
	}
	print OUT1 "\n";
}

my (%Mutation1,%Mutation2);
my $mut;
while(<IN2>){
	chomp;
	my @tmp=split /\t/,$_;
	$mut++;
	$Mutation1{$mut}=$tmp[0];
	$Mutation2{$tmp[0]}{1}=$tmp[2];
	$Mutation2{$tmp[0]}{2}=$tmp[3];
}
$count=0;
foreach my $hap(sort {$hash1{$b} <=> $hash1{$a}} keys %hash1){
	$count++;
	print OUT2 "hap$count\t";
	foreach my $var(sort {$a <=> $b} keys %Mutation1){
		if(exists $hash3{$hap}{$Mutation1{$var}}){
			print OUT2 "$Mutation2{$Mutation1{$var}}{2}";
		}
		else{
			print OUT2 "$Mutation2{$Mutation1{$var}}{1}";
		}
	}
	print OUT2 "\n";
}

