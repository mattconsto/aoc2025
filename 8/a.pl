#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw(product);

my @boxes;
my $limit;
while (<STDIN>) {
    chomp;
    push @boxes, [$1, $2, $3] if /^(\d+),(\d+),(\d+)$/;
    $limit = $1 if /^(\d+)$/;
}

my %dists;
for (my $i = 0; $i < @boxes; $i++) {
    for (my $j = $i + 1; $j < @boxes; $j++) {
        $dists{"$i:$j"} = sqrt(
            ($boxes[$i][0] - $boxes[$j][0]) ** 2 +
            ($boxes[$i][1] - $boxes[$j][1]) ** 2 +
            ($boxes[$i][2] - $boxes[$j][2]) ** 2
        );
    }
}

my $i = 0;
my %maps;
my $sets = 0;
for my $pair (sort {$dists{$a} <=> $dists{$b}} keys %dists) {
    last if $i++ >= $limit;

    my ($one, $two) = $pair =~ /^(\d+)\:(\d+)$/;
    
    if (exists $maps{$one} && exists $maps{$two}) {
        for my $key (keys %maps) {
            if ($maps{$key} == $maps{$two} && $key != $two) {
                $maps{$key} = $maps{$one};
            }
        }
        $maps{$two} = $maps{$one};
    } elsif (exists $maps{$one}) {
        $maps{$two} = $maps{$one};
    } elsif (exists $maps{$two}) {
        $maps{$one} = $maps{$two};
    } else {
        $maps{$one} = $maps{$two} = $sets++;
    }
}

my %sizes;
$sizes{$maps{$_}}++ for keys %maps;
print product(@{[sort {$b <=> $a} values %sizes]}[0..2]) . "\n";
