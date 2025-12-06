#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw(product sum);

my @lines;
while (<STDIN>) {
    chomp;
    push @lines, "$_ ";
}

my @numbers;
my $op;
my $total = 0;
for (my $i = 0; $i < length $lines[-1]; $i++) {
    my $li = substr $lines[-1], $i, 1;
    if ($li ne ' ') {
        @numbers = ();
        $op = $li;
    }

    my $number;
    for (my $j = 0; $j < scalar @lines - 1; $j++) {
        my $lj = substr $lines[$j], $i, 1;
        next if $lj eq ' ';

        $number = ($number // 0) * 10 + $lj;
    }

    if (defined $number) {
        push @numbers, $number;
    } else {
        if ($op eq '+') {
            $total += sum(@numbers);
        } elsif ($op eq '*') {
            $total += product(@numbers);
        }
    }
}
print "$total\n";
