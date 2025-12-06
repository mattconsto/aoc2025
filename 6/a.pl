#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw(product sum);

my @questions;
while (<STDIN>) {
    chomp;
    my @line = split /\s+/, s/^\s+|\s+$//gr;
    if ($line[0] =~ /^\d+$/) {
        for (my $i = 0; $i < @line; $i++) {
            push @{$questions[$i]}, $line[$i];
        }
    } else {
        my $total = 0;
        for (my $i = 0; $i < @line; $i++) {
            if ($line[$i] eq '+') {
                $total += sum(@{$questions[$i]});
            } elsif ($line[$i] eq '*') {
                $total += product(@{$questions[$i]});
            }
        }
        print "$total\n";
    }
}
