#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(IN3,"$ARGV[2]") || die "Can't open IN3!\n";
open(OUT1,">$ARGV[3]") || die "Can't open OUT1!\n";
open(OUT2,">$ARGV[4]") || die "Can't open OUT2!\n";

my $dir1="/share/home/zhanglab/user/liujing/LiuJing/00_chrY/Freezed/Freeze_v0.9";
my $dir2="/share/home/zhanglab/user/liujing/LiuJing/00_chrY/43Ys/All";
my $dir3="/share/home/zhanglab/user/liujing/LiuJing/00_chrY/Ref";
my $Ref="HG03248";
my %hash1;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$hash1{$tmp[0]}=$tmp[-1];
}
my %hash2;
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	next if($tmp[-1] eq "Yellow" || $tmp[-1] eq "Teal");
	$hash2{$tmp[1]}=$tmp[-1];
}
my %hash3;
my %AMP;
while(<IN3>){
	chomp;
	my @tmp=split /\s+/,$_;
	my ($sample,$chr)=split /\#/,$tmp[0];
	next unless(exists $hash2{$tmp[3]});
	my $type=$hash2{$tmp[3]};
	my $len=$tmp[2]-$tmp[1]+1;
	$AMP{$sample}{$tmp[3]}="$chr\t$tmp[1]\t$tmp[2]\t$tmp[4]";
	if(!exists $hash3{$type}){
		system "mkdir $type";
	}
	push(@{$hash3{$type}},$len);
}

my %hash4;
foreach my $type(sort {$a cmp $b} keys %hash3){
	my @tmp=sort {$a <=> $b} @{$hash3{$type}};
	my $index1=int(($#tmp+1)*0.05);
	my $index2=int(($#tmp+1)*0.95);
	$hash4{$type}{1}=$tmp[$index1];
	$hash4{$type}{2}=$tmp[$index2];
	print OUT1 "$type\t$tmp[$index1]\t$tmp[$index2]\n";
}
print OUT2 "#!/bin/bash\n\n#SBATCH --job-name=extract_amp\n#SBATCH --partition=cpu64\n#SBATCH --cpus-per-task=1\n#SBATCH --mem=2G\n#SBATCH --output=extract_amp.o\n#SBATCH --error=extract_amp.e\n\n";
my %output;
foreach my $sam(sort {$a cmp $b} keys %AMP){
	my $proj=$hash1{$sam};
	my $genome;
	if($proj eq "APG"){
		$genome="$dir1/$sam.chrY.freeze.fa";
	}
	elsif($proj eq "43Y"){
		$genome="$dir2/$sam.HIFIRW.ONTUL.na.chrY.fasta";
	}
	else{
		$genome="$dir3/$sam.chrY.fa";
	}
	foreach my $amp(sort {$a cmp $b} keys %{$AMP{$sam}}){
		my $type=$hash2{$amp};
		my @tmp=split /\t/,$AMP{$sam}{$amp};
		my $len=$tmp[2]-$tmp[1]+1;
		next unless($len>=$hash4{$type}{1} && $len<=$hash4{$type}{2});
		open(BED,">$type/$sam.$amp.bed") || die "Can't open BED!\n";
		if($proj eq "APG"){
			print BED "$sam\#$tmp[0]\t$tmp[1]\t$tmp[2]\t$sam\@$amp\t0\t$tmp[3]\n";
		}
		else{
			print BED "$tmp[0]\t$tmp[1]\t$tmp[2]\t$sam\@$amp\t0\t$tmp[3]\n";
		}
		close BED;
		print OUT2 "bedtools getfasta -fi $genome -bed $type/$sam.$amp.bed -fo $type/$sam.$amp.fa -nameOnly -s\nsed -i \'s/(.*)\$//\' $type/$sam.$amp.fa\n";
		next if($sam eq $Ref);
		$output{$type}.="nucmer -t 8 --mum -p $type/$sam.$amp $type/$Ref.$amp.fa $type/$sam.$amp.fa\ndelta-filter -i 95 -o 95 $type/$sam.$amp.delta -1 > $type/$sam.$amp.best.delta\nshow-snps -r -T $type/$sam.$amp.best.delta > $type/$sam.$amp.align.txt\n~/Software/synPlot/bin/nucmer2SNP_InDel.pl $type/$sam.$amp.align.txt $type/$sam.$amp.align.snp.txt $type/$sam.$amp.align.indel.txt\n\n";
	}
}

foreach my $type(sort {$a <=> $b} keys %output){
	open(OUT,">02.numcer_$type.sh") || die "Can't open OUT!\n";
	print OUT "#!/bin/bash\n\n#SBATCH --job-name=numcer_$type\n#SBATCH --partition=cpu64\n#SBATCH --cpus-per-task=8\n#SBATCH --mem=5G\n#SBATCH --output=numcer_$type.o\n#SBATCH --error=numcer_$type.e\n\n";
	print OUT "$output{$type}\n";
}

