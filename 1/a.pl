#!/usr/bin/env perl

use strict;
use warnings;

my $pos = 50;
my $total = 0;
while (<STDIN>) {
    my ($dir, $num) = /^([LR])(\d+)/;
    if ($dir eq 'L') {
        $pos = ($pos - $num + 100) % 100;
    } else {
        $pos = ($pos + $num) % 100;
    }
    $total++ if $pos == 0;
}
print $total;
