#!/usr/bin/perl
use strict;
use List::Util qw/max min/;

open(IN,"$ARGV[0]") || die "Can't open IN!\n";
my $dir=$ARGV[1];
my $outdir=$ARGV[2];
my %hash;
my %rank;
while(<IN>){
	chomp;
	my @tmp=split /\s+/,$_;
	my ($sam,$lib)=split /\-/,$tmp[-1];
	$rank{$sam}++;
	$hash{$sam}{$rank{$sam}}=$tmp[0];
}

my $ref_dir="/share/home/zhanglab/user/liujing/LiuJing/09_testis/Reference/Human";
foreach my $sam(sort {$a cmp $b} keys %hash){
	open(OUT,">$sam.fq2bam.sh") || die "Can't open OUT!\n";
	print OUT "#!/bin/bash\n\n#SBATCH --job-name=$sam\n#SBATCH --partition=cpu64,cpu128\n#SBATCH --cpus-per-task=8\n#SBATCH --mem=20G\n#SBATCH --output=$sam.o\n#SBATCH --error=$sam.e\n\n";
	my $bam_files;
	my $tmp_bam;
	foreach my $lib(sort {$a cmp $b} keys %{$hash{$sam}}){
		my $sra=$hash{$sam}{$lib};
		my $RG="\"\@RG\\tID:$sam\\tSM:$sam\\tLB:lib$lib\\tPL:Illumina\"";
		print OUT "trimmomatic PE -phred33 -threads 8 $dir/$sra/$sra\_f1.fq.gz $dir/$sra/$sra\_r2.fq.gz $dir/$sra/$sra\_R1.clean.fq.gz $dir/$sra/$sra\_R1.discard.fq.gz $dir/$sra/$sra\_R2.clean.fq.gz $dir/$sra/$sra\_R2.discard.fq.gz ILLUMINACLIP:$ref_dir/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36\nrm $dir/$sra/$sra\_R1.discard.fq.gz $dir/$sra/$sra\_R2.discard.fq.gz\n";
		print OUT "bwa mem -t 8 -M -R $RG $ref_dir/Human.fa $dir/$sra/$sra\_R1.clean.fq.gz $dir/$sra/$sra\_R2.clean.fq.gz | samtools view -Sbh > $dir/$sra/$sra.bam\nrm $dir/$sra/$sra\_f1.fq.gz $dir/$sra/$sra\_r2.fq.gz\n\n";
		$bam_files.="$dir/$sra/$sra.bam ";
		if($tmp_bam eq ""){
			$tmp_bam="$dir/$sra/$sra.bam";
		}
	}
	print OUT "samtools merge -\@8 -h $tmp_bam $outdir/$sam.bam $bam_files\n";
	print OUT "samtools sort -\@8 $outdir/$sam.bam -o $outdir/$sam.sort.bam\n";
	print OUT "picard MarkDuplicates I=$outdir/$sam.sort.bam O=$outdir/$sam.sort.dedup.bam M=$outdir/$sam.dedup REMOVE_DUPLICATES=true ASSUME_SORTED=true\n";
	print OUT "rm $bam_files $outdir/$sam.bam $outdir/$sam.sort.bam\n";
}

