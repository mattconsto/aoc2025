#!/usr/bin/env perl

use strict;
use warnings;

my @gifts;
my $total = 0;
while (<STDIN>) {
    chomp;
    if (/^(\d+):$/) {
        push @gifts, [];
    } elsif (/^([\.#]+)$/) {
        $gifts[-1][1] += length $1;
        $gifts[-1][0] += () = $1 =~ /#/g;
    } elsif (/^(\d+)x(\d+):\s([\d\s]+)$/) {
        my $area = $1 * $2;
        my @want = split /\s+/, $3;

        my $min = 0;
        my $max = 0;
        for (my $i = 0; $i < @want; $i++) {
            $min += $want[$i] * $gifts[$i][0];
            $max += $want[$i] * $gifts[$i][1];
        }

        if ($max <= $area) {
            $total++;
        } elsif ($min <= $area) {
            die 'Unknown';
        }
    }
}
print "$total\n";
