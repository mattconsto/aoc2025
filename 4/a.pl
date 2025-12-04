#!/usr/bin/env perl

use strict;
use warnings;

my @map;
while (<STDIN>) {
    chomp;
    push @map, $_;
}

my $total = 0;
for (my $y = 0; $y < scalar @map; $y++) {
    for (my $x = 0; $x < length $map[$y]; $x++) {
        next unless (substr $map[$y], $x, 1) eq '@';

        my $touches = 0;
        for (my $i = -1; $i <= 1; $i++) {
            for (my $j = -1; $j <= 1; $j++) {
                next if $i == 0 && $j == 0;
                next if $y + $i < 0 || $y + $i >= scalar @map;
                next if $x + $j < 0 || $x + $j >= length $map[$y + $i];

                $touches++ if (substr $map[$y + $i], $x + $j, 1) eq '@';
            }
        }

        $total++ if $touches < 4;
    }
}

print "$total\n";
