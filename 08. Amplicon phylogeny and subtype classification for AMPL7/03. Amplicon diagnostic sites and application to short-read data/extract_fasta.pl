#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

my $dir=$ARGV[0];
open(OUT1,">$ARGV[1]") || die "Can't open OUT1!\n";
my $outfile=$ARGV[2];

opendir(DIR,"$dir") || die "Can't open DIR!\n";
my $fafile;
while($fafile=readdir(DIR)){
	if($fafile=~ /(.*)\.(.*)\.fa\z/){
		my $sam="$1\-$2";
		my $type=$2;
		$type=~ s/ga/gy/g;
		print OUT1 "$sam\t$type\n";
		system "cat $dir/$fafile >> $outfile";
	}
}
