#!/usr/bin/env perl

use strict;
use warnings;

use Const::Fast;

const my $LENGTH => 12;

my $total = 0;
while (<STDIN>) {
    chomp;
    my @digits = (0, split //);
    my @result = (0);
    for my $digit (1..$LENGTH) {
        my $max = $result[-1] + 1;
        for (my $i = $result[-1] + 2; $i < scalar @digits - ($LENGTH - $digit); $i++) {
            $max = $i if $digits[$i] > $digits[$max];
        }
        push @result, $max;
    }
    $total += join '', map {$digits[$_]} @result;
}
print $total;
