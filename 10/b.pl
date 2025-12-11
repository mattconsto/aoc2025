#!/usr/bin/env perl

use strict;
use warnings;

use Fcntl qw(:seek);
use File::Temp qw(tempfile);
use IPC::System::Simple qw(capturex);

my @ALPHABET = ('a' .. 'z');

my ($fh, $filename) = tempfile();

my $total = 0;
while (<STDIN>) {
    chomp;

    if (/^\[([(\.#)]+)\]\s+((?:\([\d,]+\)\s*)+)\s+\{([\d,]+)\}$/) {
        my @buttons = map {{map {$_ => undef} split /,+/, s/^\(|\)$//gr}} split /\s+/, $2;
        my @targets = split /,+/, $3;

        truncate $fh, 0;
        seek $fh, 0, SEEK_SET;

        print $fh "min: @{[join ' + ', @ALPHABET]};\n";
        for (my $i = 0; $i < @targets; $i++) {
            for (my $j = 0; $j < @buttons; $j++) {
                print $fh $ALPHABET[$j] . " + " if exists $buttons[$j]{$i};
            }
            print $fh " 0 = " . $targets[$i] . ";\n";
        }
        print $fh "int @{[join ', ', @ALPHABET]};\n";

        # sudo apt install lp-solve
        my $out = capturex('lp_solve', '-S1', $filename);
        my ($num) = $out =~ /^\s*Value of objective function: (\d+)\.0+\s*$/;
        $total += $num;
    }
}
print "$total\n";
