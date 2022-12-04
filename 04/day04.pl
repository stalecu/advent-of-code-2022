#!/usr/bin/env perl
use strict;
use warnings;
use v5.36;

sub get_lines($filename) {
    if (-e -f -r $filename) {
        open(my $fh, "<", $filename) or die $!;
        my @pairs;
        while (my $line = <$fh>) {
            chomp $line;
            push @pairs, [map {int($_)} ($line =~ /[0-9]+/g)];
        }
        close($fh);
        return @pairs;
    }
    ();
}

my @lines = get_lines("./input");
my $part1Score = 0;
my $part2Score = 0;
foreach my $line (@lines) {
    my $s1 = @$line[0];
    my $e1 = @$line[1];
    my $s2 = @$line[2];
    my $e2 = @$line[3];
    $part1Score += (($s1 <= $s2 and $e2 <= $e1) or ($s1 >= $s2 and $e1 <= $e2));
    $part2Score += ($s1 <= $e2 and $s2 <= $e1);
}
print $part1Score, " ", $part2Score, "\n";
