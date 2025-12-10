#!/usr/bin/env perl

use strict;
use warnings;

my @tiles;
while (<STDIN>) {
    chomp;
    push @tiles, [$1, $2] if /^(\d+),(\d+)$/;
}

my %x_lines;
my %y_lines;
for (my $i = 0; $i < @tiles; $i++) {
    if ($tiles[$i][0] == $tiles[$i-1][0]) {
        push @{$x_lines{$tiles[$i][0]}}, [sort $tiles[$i][1], $tiles[$i-1][1]];
    } else {
        push @{$y_lines{$tiles[$i][1]}}, [sort $tiles[$i][0], $tiles[$i-1][0]];
    }
}

my @x_keys = sort {$a <=> $b} keys %x_lines;
my @y_keys = sort {$a <=> $b} keys %y_lines;

my $max = 0;
for (my $i = 0; $i < @tiles; $i++) {
    RECT: for (my $j = $i + 2; $j < @tiles; $j++) { # never adjacent
        my @xs = sort {$a <=> $b} $tiles[$i][0], $tiles[$j][0];
        my @ys = sort {$a <=> $b} $tiles[$i][1], $tiles[$j][1];

        for my $x (@x_keys) {
            next if $x <= $xs[0];
            last if $x >= $xs[1];

            for my $line (@{$x_lines{$x}}) {
                next RECT if $line->[0] < $ys[1] && $line->[1] > $ys[0];
            }
        }

        for my $y (@y_keys) {
            next if $y <= $ys[0];
            last if $y >= $ys[1];

            for my $line (@{$y_lines{$y}}) {
                next RECT if $line->[0] < $xs[1] && $line->[1] > $xs[0];
            }
        }

        if ((my $area = ($xs[1]-$xs[0]+1) * ($ys[1]-$ys[0]+1)) > $max) {
            $max = $area;
        }
    }
}
print "$max\n";
