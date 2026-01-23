#!/usr/bin/perl
use strict;
use warnings;

if (@ARGV != 1) {
    die "Usage: $0 input_file\n";
    }

    my $input_file = $ARGV[0];
    my @lines_to_delete = (3, 6, 8, 11, 14, 18, 19, 25, 28);

    open(my $in_fh, '<', $input_file) or die "Can't open $input_file: $!";
    open(my $temp_fh, '>', "$input_file.temp") or die "Can't open temporary file: $!";

    my $line_number = 1;
    while (<$in_fh>) {
        print $temp_fh $_ unless grep { $line_number == $_ } @lines_to_delete;
            $line_number++;
            }

            close $in_fh;
            close $temp_fh;
            # 删除原始文件并将临时文件重命名为原始文件
            unlink $input_file or die "Can't remove $input_file: $!";
            rename "$input_file.temp", $input_file or die "Can't rename: $!";
            print "Lines deleted successfully.\n";
