#!/usr/bin/env perl

use strict;
use warnings;

my $total = 0;
while (<STDIN>) {
    for (split /,/) {
        if (my ($start, $stop) = /^(\d+)-(\d+)$/) {
            for (my $i = $start; $i <= $stop; $i++) {
                my $len = length $i;
                for (my $j = 1; $j <= $len / 2; $j++) {
                    next unless $len % $j == 0;

                    my $want = substr $i, 0, $j;
                    my $success = 1;
                    for (my $k = 1; $k < $len / $j; $k++) {
                        next if (substr $i, $j * $k, $j) == $want;

                        $success = 0;
                        last;
                    }

                    if ($success) {
                        $total += $i;
                        last;
                    }
                }
            }
        }
    }
}
print $total;
