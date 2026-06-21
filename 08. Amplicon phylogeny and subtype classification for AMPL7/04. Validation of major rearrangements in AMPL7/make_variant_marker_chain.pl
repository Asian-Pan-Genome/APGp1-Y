#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

my $dir="/share/home/zhanglab/user/liujing/LiuJing/03_pangenome/SV/AMP/Reconstruction/New_order/Re_name/Inversion_validation";
opendir(DIR,"$dir") || die "Can't open DIR!\n";
open(IN1,"$ARGV[0]") || die "Can't open IN1!\n";
open(IN2,"$ARGV[1]") || die "Can't open IN2!\n";
open(IN3,"$ARGV[2]") || die "Can't open IN3!\n";
#open(OUT,">$ARGV[1]") || die "Can't open OUT!\n";
my %Amp_type;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/,$_;
	$Amp_type{$tmp[1]}="$tmp[2]\t$tmp[-2]\t$tmp[-1]";
}
my %Short_blue;
while(<IN2>){
	chomp;
	$Short_blue{$_}=1;
}

my %hash;
my %Variant;
my $vcf_file;
while($vcf_file=readdir(DIR)){
	if($vcf_file=~ /(.*).all.merge.MAF0.1.vcf\z/){
		my $AMP=$1;
		open(INPUT,"$dir/$vcf_file") || die "Can't open IN!\n";
		my @header;
		while(<INPUT>){
			chomp;
			if(/^#/){
				@header=split /\s+/,$_;
			}
			else{
				my @tmp=split /\s+/,$_;
				$Variant{$AMP}{$tmp[1]}="$tmp[3]\t$tmp[4]";
				for(my $i=9;$i<=$#tmp;$i++){
					my ($sam,$amp)=split /\./,$header[$i];
					if(exists $Short_blue{$header[$i]} && $tmp[1]>167000){
						$hash{$sam}{$amp}{$tmp[1]}="NA";
					}
					else{
						if($tmp[$i]==1){
							$hash{$sam}{$amp}{$tmp[1]}="A";
						}
						else{
							$hash{$sam}{$amp}{$tmp[1]}="R";
						}
					}
				}
			}
		}
	}
}

my %Ampl;
while(<IN3>){
	chomp;
	my @tmp=split /\s+/,$_;
	my $sam=(split /\#/,$tmp[0])[0];
	$Ampl{$sam}{$tmp[1]}="$tmp[0]\t$tmp[1]\t$tmp[2]\t$tmp[3]\t$tmp[4]";
}

foreach my $sam(sort {$a cmp $b} keys %Ampl){
	open(OUT,">$sam.amplicons.variant_markers.list") || die "Can't open OUT!\n";
	foreach my $start(sort {$a <=> $b} keys %{$Ampl{$sam}}){
		my @tmp=split /\s+/,$Ampl{$sam}{$start};
		my ($col,$AMP1,$AMP2)=split /\t/,$Amp_type{$tmp[3]};
		if($tmp[4] eq "-"){
			foreach my $pos(sort {$b <=> $a} keys %{$Variant{$AMP1}}){
				if(exists $hash{$sam}{$tmp[3]}){
					print OUT "$Ampl{$sam}{$start}\t$col\t$AMP2\_$pos\_$hash{$sam}{$tmp[3]}{$pos}\n";
				}
				else{
					print OUT "$Ampl{$sam}{$start}\t$col\tNA\n";
				}
			}
		}
		else{
			foreach my $pos(sort {$a <=> $b} keys %{$Variant{$AMP1}}){
				if(exists $hash{$sam}{$tmp[3]}){
					print OUT "$Ampl{$sam}{$start}\t$col\t$AMP2\_$pos\_$hash{$sam}{$tmp[3]}{$pos}\n";
				}
				else{
					print OUT "$Ampl{$sam}{$start}\t$col\tNA\n";
				}
			}
		}
	}
}
