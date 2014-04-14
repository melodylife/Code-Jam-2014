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
    #print "This is the line $line\n";
    $case_num ++;
    my @case = split(/ / , $line); 
    my $C = $case[0];
    my $F = $case[1];
    my $X = $case[2];

    #print "C: $C F: $F X:$X\n";
    my $max_farm = int(($X - 2) / $F + 0.99); 
    $max_farm = ($max_farm > 0)? $max_farm : 0;
    
    #print "This is the max farm $max_farm \n";

    my $f_num = 0;
    for( $f_num = 0; $f_num < $max_farm; $f_num ++)
    {
        my $temp1 = $C / (2 + $f_num * $F);
        my $temp2 = $X / (2 + (($f_num + 1) * $F));
        my $total_next = $temp1 + $temp2;

        my $total_cur = $X / (2 + $f_num * $F);
        if(85 == $case_num)
        {
            #print "This is the farm number and time $f_num $total_cur $total_next\n";
        }

        if($total_cur < $total_next)
        {
            $t += $total_cur;
            last;
        }
        $t += $temp1;
    }

    #print "This is the farm number $f_num\n";
    if(0 == $f_num)
    {
        $t = int(($X / 2) + 0.99);
        #print "Hello \n";
    }
    $t = ($t < 1)? (1 + $t) : $t;
    printf ("Case #%d: %.7f\n" , $case_num , $t);
}


