#!/usr/bin/env perl

use strict;
use warnings;

my @ids;
my @ranges;
while (<STDIN>) {
    chomp;
    push @ranges, [split /-/, $1] if /^(\d+-\d+)$/;
    push @ids, $1 if /^(\d+)$/;
}

my $total = 0;
for my $id (@ids) {
    for my $range (@ranges) {
        if ($id >= $range->[0] && $id <= $range->[1]) {
            $total++;
            last;
        }
    }
}
print $total;
