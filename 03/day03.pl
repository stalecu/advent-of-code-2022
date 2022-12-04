#!/usr/bin/env perl
use strict;
use warnings;
use v5.36;
use List::MoreUtils qw(uniq);

sub get_lines($filename) {
    if (-e -f -r $filename) {
        open(my $fh, "<", $filename) or die $!;
        my @lines = <$fh>;
        chomp @lines;
        close($fh);
        return @lines;
    }
    ();
}
sub priority($item) {
    if ($item =~ /[a-z]/) { return ord($item) - ord('a') + 1; }
    if ($item =~ /[A-Z]/) { return ord($item) - ord('A') + 27; }
    return 0;
}

sub get_unique_priorities($str) {
    return
      sort { $a <=> $b } (map { priority($_) } ( uniq( split "", $str ) ) );

}

sub split_arr_into_chunks($length, @arr) {
    my @chunks = ();
    push @chunks, [ splice @arr, 0, $length ] while @arr;
    return @chunks;
}


sub split_string_in_two($str) {
    my @chars = split "", $str;
    my @chunks = split_arr_into_chunks(length($str) / 2, @chars );
    my @splitStrings;
    foreach my $f (@chunks) {
        push @splitStrings, (join "", @$f);
    }
    return @splitStrings;
}

sub part1(@lines) {
    my $score      = 0;
    my @temp_lines = @lines;
    foreach my $e (@temp_lines) {
        foreach my $f ($e) {
            my ($str_a, $str_b) = split_string_in_two($f);
            my @chars_a = get_unique_priorities($str_a);
            my @chars_b = get_unique_priorities($str_b);
            my $i = 0;
            my $j = 0;
            while ( $i <= $#chars_a && $j <= $#chars_b) {
                if ($chars_a[$i] == $chars_b[$j])
                {
                    $score += $chars_a[$i];
                    $i++;
                    $j++;
                }
                elsif ( $chars_a[$i] < $chars_b[$j] ) { $i++; }
                else                                  { $j++; }
            }
        }

    }
    return $score;
}

sub part2 (@lines) {
    my @chunks = split_arr_into_chunks(3, @lines);
    my $score = 0;
    foreach my $e (@chunks) {
        foreach my $f ($e) {
            my ($str_a, $str_b, $str_c) = @$f;

            my @chars_a = get_unique_priorities($str_a);
            my @chars_b = get_unique_priorities($str_b);
            my @chars_c = get_unique_priorities($str_c);

            my $i = 0; my $j = 0; my $k = 0;
            while ($i <= $#chars_a && $j <= $#chars_b && $k <= $#chars_c) {
                if ($chars_a[$i] == $chars_b[$j] and $chars_b[$j] == $chars_c[$k]) {
                    $score += $chars_a[$i];
                    $i++; $j++; $k++;
                }
                elsif ( $chars_a[$i] < $chars_b[$j] ) { $i++; }
                elsif ( $chars_b[$j] < $chars_c[$k] ) { $j++; }
                else { $k++; }
            }
        }

    }
    return $score;
}


my @sample_lines = get_lines("./sample-input");
my @actual_lines = get_lines("./input");


printf "Sample input: %d %d\nActual input: %d %d\n",
    part1(@sample_lines), part2(@sample_lines),
    part1(@actual_lines), part2(@actual_lines);
