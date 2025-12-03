#!/usr/bin/env perl

use strict;
use warnings;

my $total = 0;
while (<STDIN>) {
    chomp;
    my @digits = split //;
    my $first = 0;
    for (my $i = 1; $i < scalar @digits - 1; $i++) {
        $first = $i if $digits[$i] > $digits[$first];
    }
    my $second = $first + 1;
    for (my $j = $second + 1; $j < scalar @digits; $j++) {
        $second = $j if $digits[$j] > $digits[$second];
    }
    $total += $digits[$first] . $digits[$second];
}
print $total;
