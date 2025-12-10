#!/usr/bin/env perl

use strict;
use warnings;

my @tiles;
while (<STDIN>) {
    chomp;
    push @tiles, [$1, $2] if /^(\d+),(\d+)$/;
}

my $max = 0;
for (my $i = 0; $i < @tiles; $i++) {
    for (my $j = $i + 1; $j < @tiles; $j++) {
        my $area = abs(
            ($tiles[$i][0] - $tiles[$j][0] + 1) *
            ($tiles[$i][1] - $tiles[$j][1] + 1)
        );
        $max = $area if $area > $max;
    }
}
print "$max\n";
