#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";

my (%hash1,%hash2);
my $line;
while(<IN1>){
	chomp;
	if(/^\d+/){
		print OUT "$_\n";
	}
	else{
		my @tmp=split /\s+/,$_;
		$line++;
		$hash1{$line}=$tmp[0];
		for(my $i=1;$i<=$#tmp;$i++){
			$hash2{$line}{$i}=$tmp[$i];
		}
	}
}
my (%Control,%Conver);
my %hash3;
my %hash4;
while(<IN2>){
	chomp;
	my @tmp=split /\t/,$_;
	$hash3{$tmp[0]}=1;
	for(my $i=1;$i<=$#tmp;$i++){
		my ($sam,$type)=split /\s+/,$tmp[$i];
		if(!exists $hash4{$tmp[0]}{$type}){
			$Control{$tmp[0]}++;
			$hash4{$tmp[0]}{$type}=$sam;
		}
		else{
			$hash4{$tmp[0]}{$type}.="\t$sam";
		}
	}
}

foreach my $sam1(sort {$a cmp $b} keys %hash4){
	foreach my $type1(sort {$a cmp $b} keys %{$hash4{$sam1}}){
		foreach my $sam2(sort {$a cmp $b} keys %hash4){
			foreach my $type2(sort {$a cmp $b} keys %{$hash4{$sam2}}){
				if($hash4{$sam1}{$type1} ne $hash4{$sam2}{$type2}){
					$Conver{$sam1}{$sam2}++;
				}
			}
		}
	}
}

foreach my $line1(sort {$a <=> $b} keys %hash2){
	my $sam1=$hash1{$line1};
	print OUT "$sam1";
	foreach my $line2(sort {$a <=> $b} keys %{$hash2{$line1}}){
		my $sam2=$hash1{$line2};
		my $dis=$hash2{$line1}{$line2};
		if(exists $hash3{$sam1} && exists $hash3{$sam2}){
			$dis+=$Conver{$sam1}{$sam2};
			#print "$sam1\t$line1\t$sam2\t$line2\t$Conver{$sam1}{$sam2}\n";
		}
		elsif(exists $hash3{$sam1}){
			$dis+=$Control{$sam1};
		}
		elsif(exists $hash3{$sam2}){
			$dis+=$Control{$sam2};
		}
		print OUT "\t$dis";
	}
	print OUT "\n";
}
