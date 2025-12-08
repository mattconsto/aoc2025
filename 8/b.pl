#!/usr/bin/env perl

use strict;
use warnings;

my @boxes;
while (<STDIN>) {
    chomp;
    push @boxes, [$1, $2, $3] if /^(\d+),(\d+),(\d+)$/;
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

my $count = 0;
my %maps;
my $sets = 0;
for my $pair (sort {$dists{$a} <=> $dists{$b}} keys %dists) {
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
        $count++;
    } elsif (exists $maps{$two}) {
        $maps{$one} = $maps{$two};
        $count++;
    } else {
        $maps{$one} = $maps{$two} = $sets++;
        $count += 2;
    }

    if ($count == @boxes) {
        print $boxes[$one][0] * $boxes[$two][0] . "\n";
        last;
    }
}
