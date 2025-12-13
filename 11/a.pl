#!/usr/bin/env perl

use strict;
use warnings;

my %paths;
while (<STDIN>) {
    chomp;
    $paths{$1} = [split /\s+/, $2] if /^(\w+):\s*([\w\s]+)$/;
}

my @queue = ('you');
my $total = 1;
while (my $label = shift @queue) {
    last if $label eq 'out';

    $total += scalar @{$paths{$label}} - 1;
    push @queue, @{$paths{$label}};
}
print "$total\n";
