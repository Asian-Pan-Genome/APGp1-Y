#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT,">$ARGV[2]") || die "Can't open OUT!\n";
my $spe=(split /\./,$ARGV[1])[-2];

my %Ref_seq;
my $chr;
while(<IN1>){
	chomp;
	if(/^\>/){
		s/\>//g;
		$chr=$_;
	}
	else{
		$Ref_seq{$chr}.=$_;
	}
}

while(<IN2>){
	chomp;
	my @tmp=split /\s+/,$_;
	my $ratio=($tmp[3]-$tmp[2])/$tmp[1] if($tmp[1]>0);
	next unless($ratio>=0.95);
	my $gene_id="$spe\-$tmp[7]\-$tmp[8]";
	my $seq=substr($Ref_seq{$tmp[5]},$tmp[7]-1,$tmp[8]-$tmp[7]+1);
	if($tmp[4] eq "-"){
		$seq=reverse_complement($seq);
	}
	print OUT ">$gene_id\n$seq\n";
}
sub reverse_complement {
	my ($seq) = @_;
	$seq =~ tr/ACGTacgt/TGCAtgca/;
	return reverse($seq);
}

