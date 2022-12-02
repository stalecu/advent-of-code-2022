#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw/sum/;

sub getNumbers {
    my $filename = $_[0];
    if (-e -f -r $filename) {
        open(my $fh, "<", $filename) or die $!;
        my @playerScores = ();
        while (<$fh>) {
            push( @playerScores, $_ );
        }
        close($fh);
        return @playerScores;
    }
    return ();
}

sub sumOverNumbers {
    my $file = shift;
    my (%scores) = @_;
    my @arr = &getNumbers($file);

    return sum map { chomp $_; $scores{$_}} @arr;
}

sub part1 {
    my %part1Scores = (
        "A X" => 1+3, "A Y" => 2+6, "A Z" => 3+0,
        "B X" => 1+0, "B Y" => 2+3, "B Z" => 3+6,
        "C X" => 1+6, "C Y" => 2+0, "C Z" => 3+3
    );

    return sumOverNumbers( $_[0], %part1Scores );
}

sub part2 {
    my %part2Scores = (
        "A X" => 3, "A Y" => 4, "A Z" => 8,
        "B X" => 1, "B Y" => 5, "B Z" => 9,
        "C X" => 2, "C Y" => 6, "C Z" => 7);
    return sumOverNumbers( $_[0], %part2Scores );
}

my $sampleFilename = "/home/alecu/sample-input";
my $actualFilename = "./input";

printf "Sample input: %d %d\nActual input: %d %d\n",
    part1($sampleFilename), part2($sampleFilename),
    part1($actualFilename), part2($actualFilename);
