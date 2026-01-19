#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
my $outdir=$ARGV[2];

my %Fasta;
my $chr;
while(<IN1>){
	chomp;
	if(/^\>/){
		s/\>//g;
		$chr=$_;
	}
	else{
		$Fasta{$chr}.=$_;
	}
}

my %Regions;
while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	my ($start,$end)=split /\-/,$tmp[-1];
	my $len=$end-$start+1;
	$start=$start-1;
	my $type=$tmp[1];
	$Regions{$type}="$start\t$len";
}

foreach my $type(sort {$a cmp $b} keys %Regions){
	my ($start,$len)=split /\t/,$Regions{$type};
	open(OUT1,">$outdir/$type.fasta") || die "Can't open OUT1!\n";
	open(OUT2,">$outdir/$type.test.fasta") || die "Can't open OUT2!\n";
	foreach my $sam(sort {$a cmp $b} keys %Fasta){
		my $seq1=substr($Fasta{$sam},$start,$len);
		my $seq2=substr($Fasta{$sam},$start,100);
		print OUT1 ">$sam\n$seq1\n";
		print OUT2 ">$sam\n$seq2\n";
	}
	system "seqret -sequence $outdir/$type.fasta -outseq $outdir/$type.nex -osformat nexus";
	system "seqret -sequence $outdir/$type.test.fasta -outseq $outdir/$type.test.nex -osformat nexus";
}
