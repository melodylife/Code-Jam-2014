#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: cookie_clickr.pl
#
#        USAGE: ./cookie_clickr.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Chang Sun (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 04/12/2014 09:08:52
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

no warnings 'recursion';

open(FILE , 'input') or die "Failed to open the file $!\n";


my @case_content = <FILE>;
close(FILE);

my $case_cnt = shift(@case_content);
chomp($case_cnt);
#print "This is the case count $case_cnt\n";


my $case_num = 0;

foreach my $line (@case_content)
{
    my $t = 0;
    chomp($line);
    $case_num ++;
    my @case = split(/ / , $line); 
    my $C = $case[0];
    my $F = $case[1];
    my $X = $case[2];

    my $f_num = 0;
    my $t_rst = calc($C , $F , $X , $f_num);
    printf ("Case #%d: %.7f\n" , $case_num , $t_rst);
}

sub calc
{
    my ($C , $F , $X , $f) = @_;
    my $cur_t = $X / ($F * $f + 2);
    my $next_t = ($C / ($F * $f + 2)) + ($X  / ($F * ($f + 1) + 2)); 
    my $t = 0;
    if($next_t < $cur_t)
    {
       $t + ($C / ($F * $f + 2))+ calc($C , $F , $X , ($f + 1)); 
    }
    else
    {
        return $X / ($F * $f + 2);
    }
}
