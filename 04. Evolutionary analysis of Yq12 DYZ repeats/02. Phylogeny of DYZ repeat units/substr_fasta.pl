#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(OUT1,">$ARGV[2]") || die "Can't open OUT1!\n";
open(OUT2,">$ARGV[3]") || die "Can't open OUT2!\n";

my %hash;
while(<IN1>){
	chomp;
	s/\:/\-/g;
	my @tmp=split /\s+/,$_;
	if($tmp[-1] eq "others"){
		my $num=int(rand(10));
		if($num==1){
			$hash{$tmp[0]}=1;
			print OUT1 "fasta/$tmp[0]\n";
			print OUT2 "$_\n";
		}
        }
	elsif($tmp[-1] eq "DYZ1_2"){
                my $num=int(rand(3));
                if($num==1){
                        $hash{$tmp[0]}=1;
                        print OUT1 "fasta/$tmp[0]\n";
                        print OUT2 "$_\n";
                }
        }
	elsif($tmp[-1] eq "DYZ1_3"){
                my $num=int(rand(3));
                if($num==1){
                        $hash{$tmp[0]}=1;
                        print OUT1 "fasta/$tmp[0]\n";
                        print OUT2 "$_\n";
                }
        }
	elsif($tmp[-1] eq "3-_d"){
                my $num=int(rand(20));
                if($num==1){
                        $hash{$tmp[0]}=1;
                        print OUT1 "fasta/$tmp[0]\n";
                        print OUT2 "$_\n";
                }
        }
	elsif($tmp[-1] eq "3+_d"){
                my $num=int(rand(5));
                if($num==1){
                        $hash{$tmp[0]}=1;
                        print OUT1 "fasta/$tmp[0]\n";
                        print OUT2 "$_\n";
                }
        }
	else{
		$hash{$tmp[0]}=1;
		print OUT1 "fasta/$tmp[0]\n";
		print OUT2 "$_\n";
	}
}

my $chr;
my $judge;
while(<IN2>){
	chomp;
	if(/^\>/){
		s/\>//g;
		s/\:/\-/g;
		$chr=$_;
		if(exists $hash{$chr}){
			$judge=1;
		}
		else{
			$judge=0;
		}
	}
	else{
		if($judge==1){
			open(OUTPUT,">Kmer_analysis_r2/fasta/$chr.fa") || die "Can't open OUTPUT!\n";
			print OUTPUT ">$chr\n$_\n";
		}
	}
}

