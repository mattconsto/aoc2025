#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw(sum);

my @lines;
my %queue;
while (<STDIN>) {
    chomp;
    if (!@lines && (my $x = index $_, 'S') >= 0) {
        $queue{$x}++;
    }
    push @lines, $_;
}

for (my $y = 0; $y < scalar @lines - 1; $y++) {
    my %next;
    for my $x (keys %queue) {
        my $char = substr $lines[$y], $x, 1;
        if ($char eq '.' || $char eq 'S') {
            $next{$x} += $queue{$x};
        } elsif ($char eq '^') {
            $next{$x - 1} += $queue{$x};
            $next{$x + 1} += $queue{$x};
        }
    }
    %queue = %next;
}

print sum(values %queue) . "\n";
