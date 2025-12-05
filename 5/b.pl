#!/usr/bin/env perl

use strict;
use warnings;

my %data;
while (<STDIN>) {
    chomp;
    if (/^(\d+)-(\d+)$/) {
        $data{$1} += 1;
        $data{$2} += -1;
    }
}

my $count = 0;
my $start = 0;
my $total = 0;
for my $key (sort {$a <=> $b} keys %data) {
    if ($count == 0) {
        $start = $key;
    }
    $count += $data{$key};
    if ($count == 0) {
        $total += $key - $start + 1;
    }
}
print "$total\n";
