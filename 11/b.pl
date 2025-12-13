#!/usr/bin/env perl

use strict;
use warnings;

use List::MoreUtils qw(any part);

my $CUTOFF = 5;
my @NEEDED = qw(dac fft);
my $SOURCE = 'svr';
my $TARGET = 'out';

my %forwards;
my %reverse;
while (<STDIN>) {
    chomp;
    if (/^(\w+):\s*([\w\s]+)$/) {
        $reverse{$_}{$1} = undef for @{$forwards{$1} = [split /\s+/, $2]};
    }
}

my %depths;
my @queue1 = ([$SOURCE, 0]);
while (@queue1) {
    my ($label, $depth) = @{pop @queue1};
    next if exists $depths{$label} && $depths{$label} >= $depth;

    $depths{$label} = $depth;
    push @queue1, [$_, $depth + 1] for @{$forwards{$label}};
}

my @steps = ([$SOURCE], (
    grep {$_}
    part {$depths{$_}}
    grep {$_ ne $TARGET && keys %{$reverse{$_}} > $CUTOFF}
    keys %reverse
), [$TARGET]);

my %paths;
for (my $i = 1; $i < @steps; $i++) {
    for my $from (@{$steps[$i - 1]}) {
        for my $to (@{$steps[$i]}) {
            my @need = grep {
                $depths{$_} > $depths{$from} && $depths{$_} < $depths{$to}
            } @NEEDED;

            my @queue2 = ([$from, {}]);
            my $count = 0;
            while (@queue2) {
                my ($label, $found) = @{pop @queue2};
                $found = {%$found};

                if ($label eq $to) {
                    $count++ if keys %$found eq @need;
                    next;
                } elsif (any {$_ eq $label} @{$steps[$i]}) {
                    next;
                }

                $found->{$label} = undef if any {$_ eq $label} @need;
                push @queue2, map {[$_, $found]} @{$forwards{$label}};
            }
            $paths{$from}{$to} = $count;
        }
    }
}

my $total = 0;
my @queue3 = ([$SOURCE, 1]);
while (@queue3) {
    my ($label, $count) = @{pop @queue3};

    if ($label eq $TARGET) {
        $total += $count;
        next;
    }

    for my $to (sort keys %{$paths{$label}}) {
        next if $paths{$label}{$to} == 0;

        push @queue3, [$to, $count * $paths{$label}{$to}];
    }
}
print "$total\n";
