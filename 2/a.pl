#!/usr/bin/env perl

use strict;
use warnings;

my $total = 0;
while (<STDIN>) {
    for (split /,/) {
        if (my ($start, $stop) = /^(\d+)-(\d+)$/) {
            for (my $i = $start; $i <= $stop; $i++) {
                my $len = length $i;
                if (
                    $len % 2 == 0 &&
                    (substr $i, 0, $len / 2) == (substr $i, $len / 2)
                ) {
                    $total += $i;
                }
            }
        }
    }
}
print $total;
