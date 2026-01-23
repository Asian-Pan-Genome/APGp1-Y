#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

my $dir="/share/home/zhanglab/user/liujing/LiuJing/03_pangenome/SV/AMP/Reconstruction/New_order/Re_name";
my $Amp_type=$ARGV[0];
open(OUT1,">$Amp_type.SNP.allele.list") || die "Can't open OUT1!\n";
open(OUT2,">$Amp_type.INDEL.allele.list") || die "Can't open OUT2!\n";
my (%hash1,%hash2);
my $ndir;
my $file;
opendir(DIR,"$dir/$Amp_type") || die "Can't open DIR!\n";
while($file=readdir(DIR)){
	if($file=~ /(.*).align\.(.*)\.txt\z/){
		my $gene=$1;
		my $mut=$2;
		open(IN,"$dir/$Amp_type/$file") || die "Can't open IN!\n";
		while(<IN>){
			chomp;
			next if(/^Ref/);
			my @tmp=split /\s+/,$_;
			if($mut eq "snp"){
				$hash1{$tmp[4]}{$gene}="$tmp[2]\|$tmp[3]";
			}
			else{
				my $ref_allele;
				my $alt_allele;
				my $pos;
				$tmp[0]=~ s/\@/\./;
				$tmp[4]=~ s/\@/\./;
				if($tmp[3] eq "."){
					$ref_allele=extract_fa($tmp[0],$tmp[1],$tmp[2]);
					$alt_allele=extract_fa($tmp[4],$tmp[5]-1,$tmp[6]);
					$pos=$tmp[1];
				}
				elsif($tmp[7] eq "."){
					$ref_allele=extract_fa($tmp[0],$tmp[1]-1,$tmp[2]);
					$alt_allele=extract_fa($tmp[4],$tmp[5],$tmp[6]);
					$pos=$tmp[1]-1;
				}
				$hash2{$pos}{$gene}="$ref_allele\|$alt_allele";
			}
		}
	}
}


foreach my $pos(sort {$a <=> $b} keys %hash1){
	foreach my $gene(sort {$a cmp $b} keys %{$hash1{$pos}}){
		print OUT1 "$pos\t$gene\t$hash1{$pos}{$gene}\n";
	}
}
foreach my $pos(sort {$a <=> $b} keys %hash2){
	foreach my $gene(sort {$a cmp $b} keys %{$hash2{$pos}}){
		print OUT2 "$pos\t$gene\t$hash2{$pos}{$gene}\n";
	}
}

sub extract_fa{
	my ($sam, $start, $end)= @_;
	open(FA,"$dir/$Amp_type/$sam.fa") || die "Can't open FA!\n";
	my $ref_seq;
	while(<FA>){
		chomp;
		next if(/^\>/);
		if($ref_seq eq ""){
			$ref_seq=$_;
		}
		else{
			$ref_seq.=$_;
		}
	}
	my $seq=substr($ref_seq,$start-1,$end-$start+1);
	return $seq;
}

