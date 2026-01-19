#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(IN3,"$ARGV[2]") || die "Can't open IN3!\n";
open(OUT1,">$ARGV[3]") || die "Can't open OUT1!\n";
open(OUT2,">$ARGV[4]") || die "Can't open OUT2!\n";
my $dir="/share/home/zhanglab/user/liujing/LiuJing/02_haplogroup/Phylogeny/04_alignment/Blocks";

my %Samples;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Samples{$tmp[0]}=1;
}

my %Regions;
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Regions{$tmp[1]}="$tmp[2]\t$tmp[3]";
}

my (%Block,%Partition);
while(<IN3>){
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
	my $align_file="$dir\/$tmp[3]\/$tmp[3].fasta";
	my %Sam_fasta;
	my $sam_name;
	open(INPUT,"$align_file") || die "Can't open $tmp[3].fasta!\n";
	while(<INPUT>){
		chomp;
		if(/^\>/){
			s/\>//g;
			$sam_name=$_;
		}
		else{
			$Sam_fasta{$sam_name}.=$_;
		}
	}
	my $ref_len=length($Sam_fasta{$sam_name});
	foreach my $sam(sort {$a cmp $b} keys %Samples){
		if(exists $Sam_fasta{$sam}){
			$Block{$sam}.=$Sam_fasta{$sam};
		}
		else{
			$Block{$sam}.="-" x $ref_len;
		}
	}
}

foreach my $sam(sort {$a cmp $b} keys %Block){
	print OUT1 ">$sam\n$Block{$sam}\n";
}

my $index=0;
foreach my $pos1(sort {$a <=> $b} keys %Regions){
	my ($pos2,$type)=split /\t/,$Regions{$pos1};
	if(exists $Partition{$type}){
		my $start=$index+1;
		my $end=$start+$Partition{$type}-1;
		$index=$end;
		print OUT2 "DNA, $type = $start\-$end\n";
	}
}
