#!/usr/bin/env perl

use strict;
use warnings;

my $total = 0;
LINE: while (<STDIN>) {
    chomp;
    if (/^\[([(\.#)]+)\]\s+((?:\([\d,]+\)\s*)+)\s+\{([\d,]+)\}$/) {
        my $target  = $1;
        my @buttons = map {[split /,+/, s/^\(|\)$//gr]} split /\s+/, $2;

        my @queue = (['.' x length $target, 0]);
        my %seen;
        while (@queue) {
            my ($lights, $presses) = @{shift @queue};

            next if exists $seen{$lights};
            $seen{$lights} = undef;

            for my $button (@buttons) {
                my $new = $lights;
                for my $pos (@$button) {
                    substr($new, $pos, 1, substr($new, $pos, 1) eq '#' ? '.' : '#');
                }

                if ($new eq $target) {
                    $total += $presses + 1;
                    next LINE;
                } else {
                    push @queue, [$new, $presses + 1];
                }
            }
        }
    }
}
print "$total\n";
