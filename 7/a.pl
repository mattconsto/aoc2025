#!/usr/bin/env perl

use strict;
use warnings;

my @lines;
my @queue;
my $y = 0;
while (<STDIN>) {
    chomp;
    push @lines, $_;
    if ((my $x = index $_, 'S') >= 0) {
        push @queue, [$x, $y];
    }
    $y++;
}

my %seen;
my $total = 0;
while (my $p = shift @queue) {
    next if $p->[1] == scalar @lines - 1;
    next if exists $seen{"$p->[0],$p->[1]"};

    my $char = substr $lines[$p->[1]], $p->[0], 1;
    if ($char eq '.' || $char eq 'S') {
        push @queue, [$p->[0], $p->[1] + 1];
    } elsif ($char eq '^') {
        push @queue, [$p->[0] - 1, $p->[1] + 1];
        push @queue, [$p->[0] + 1, $p->[1] + 1];
        $seen{"$p->[0],$p->[1]"} = undef;
        $total++;
    }
}
print "$total\n";
