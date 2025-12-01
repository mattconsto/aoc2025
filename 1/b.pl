#!/usr/bin/env perl

use strict;
use warnings;

my $pos = 50;
my $total = 0;
while (<STDIN>) {
    my ($dir, $num) = /^([LR])(\d+)/;
    if ($dir eq 'L') {
        for (my $i = 0; $i < $num; $i++) {
            $pos--;
            $total++ if $pos % 100 == 0;
        }
    } else {
        for (my $i = 0; $i < $num; $i++) {
            $pos++;
            $total++ if $pos % 100 == 0;
        }
    }
    $pos = ($pos + 100) % 100;
}
print $total;
