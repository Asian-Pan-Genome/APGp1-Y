#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

if(@ARGV != 6) {
	die "Usage: perl $0 regions.bed input.maf output.maf <min_length> <min_informative_sites> <missing_threshold>\n";
}

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";
my $min_length=$ARGV[3];
my $min_informative_sites=$ARGV[4];
my $missing_threshold=$ARGV[5];

my %Regions;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Regions{$tmp[1]}=$tmp[2];
}

my $block_info;
my $block_jug;
my $block_len;
my $block_num;
my %block_nuc;
while(<IN2>){
	chomp;
	if(/^##/){
		print OUT "$_\n\n";
	}
	elsif(/^a/){
		if($block_info ne ""){
			my $informative_sites;
			foreach my $pos(sort {$a <=> $b} keys %block_nuc){
				my $count;
				foreach my $key(sort {$a <=> $b} keys %{$block_nuc{$pos}}){
					next if($key eq "-");
					$count++;
				}
				if($count>1){
					$informative_sites++;
				}
			}
			if($informative_sites>=$min_informative_sites){
				print OUT "$_\n$block_info\n";
			}
		}
		$block_info="";
		$block_jug="";
		$block_num="";
		%block_nuc=();
	}
	elsif(/^s/){
		my @tmp=split /\s+/,$_;
		#print "$_\n";
		$block_num++;
		if($block_num==1){
			if($tmp[3]<$min_length){
				$block_jug=2;
			}
			next if($block_jug==2);	
			foreach my $pos1(sort {$a <=> $b} keys %Regions){
				last if($tmp[2]+$tmp[3]<$pos1);
				my $pos2=$Regions{$pos1};
				if($tmp[2]<=$pos2 && $tmp[2]+$tmp[3]>=$pos1){
					$block_jug=1;
					last;
				}
			}
			$block_len=$tmp[3];
		}
		next if($block_jug!=1);
		next if($tmp[1]=~ /MINIGRAPH|GRC/);
		my $missing_count=($tmp[-1] =~ tr/-//);
		next if($missing_count>$block_len*$missing_threshold);
		my @arr=split //,$tmp[-1];
		for(my $i=0;$i<=$#arr;$i++){
			my $nuc=uc($arr[$i]);
			$block_nuc{$i}{$nuc}++;
		}
		my $sample=(split /\./,$tmp[1])[0].".chrY";
		$block_info.="$tmp[0]\t$sample\t$tmp[2]\t$tmp[3]\t$tmp[4]\t$tmp[5]\t$tmp[6]\n";
	}
}
