#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use List::Util qw/sum/;

my $filename = "./input";

sub getNumbers {
    my $filename = $_[0];
    if (-e -f -r $filename) {
        open(my $fh, "<", $filename) or die $!;
        my $content = do { local $/; <$fh> };
        close($fh);

        my @lines = split /\n/, $content;

        @lines = map {if ($_ eq "") { 0 } else { int($_) }} @lines;
        push(@lines, 0);
        return @lines;
    }
    ();
}

sub findSums {
    my @nums = &getNumbers($_[0]);
    my @sums = ();
    my $sum = 0;
    foreach (@nums) {
        if ($_ != 0) {
            $sum += $_;
        }
        else {
            push(@sums, $sum);
            $sum = 0;
        }
    }
    @sums = sort {$b <=> $a} @sums;

    return @sums;
}

sub part1 {
    my @sums = &findSums($_[0]);

    return $sums[0];
}

sub part2 {
    my @sums = &findSums($_[0]);
    return $sums[0] + $sums[1] + $sums[2];
}

print part1($filename), ' ', part2($filename), "\n";
