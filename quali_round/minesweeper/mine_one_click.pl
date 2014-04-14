#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: mine_one_click.pl
#
#        USAGE: ./mine_one_click.pl  
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
#      CREATED: 04/13/2014 04:09:48
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;
use List::MoreUtils qw(uniq);


open(FILE , 'input') or die "Failed to open the file $!\n";

my @case_content = <FILE>;
my $case_cnt = shift(@case_content);
chomp($case_cnt);

close(FILE);

for(my $i = 0; $i < $case_cnt; $i ++)
{
    my $case_num = $i + 1;
    print "Case #$case_num:\n";
    my $line = $case_content[$i];
    chomp($line);
    my ($R , $C , $M) = split(/ / , $line);
    my $min_dim = (($R < $C) ? $R : $C);
    my $total = $R * $C; 

    #print "This is the min dim of case $case_num  $min_dim\n";
    my $factor = ($min_dim > 3) ? 3 : $min_dim;

    if(($total - $M < (2 ** $factor  + 1)) && ($min_dim != 1))
    {
        print "Impossible\n";
        next;
    }

    my $safe_pile = $total - $M;
    #print "This is the safe tile $safe_pile\n";
    my @graph = ();
    init_array($R , $C , \@graph);

    #always start from 0
    my @points = ();
    push(@points , '0 0');
    while(1)
    {
        my $end_flag = 0;
        foreach my $point (@points)
        {
            my $len = @points;
            my @neighbor = find_neighbor($R , $C , $point);


            foreach my $nn (@neighbor)
            {
                #print "Here are neighbors $nn\n";
            }

            my $nei_len = @neighbor;
            #   print "The current len is $len and the safe pile num is $safe_pile \n";
            for(my $nei_num = 0; $nei_num < $nei_len; $nei_num ++)
            {
                #   print "This is the point $neighbor[$nei_num] $nei_num\n";
                if((0 == find_iden($neighbor[$nei_num] , \@points , $len)) && (($len + 1) <= $safe_pile))
                {
                    #print "push the pt into result $neighbor[$nei_num]\n";
                    push(@points , $neighbor[$nei_num]);
                    $len ++;
                }
                if(($len + 1) > $safe_pile)
                {
                    $end_flag = 1;
                    last;
                }
            }

            if(1 == $end_flag)
            {
                last;
            }


        }

        if(1 == $end_flag)
        {
            last;
        }
    }

    my $click_flag = 0;
    foreach my $pt (@points)
    {
        #print "This is the point $pt\n";
        my ($x , $y) = split(/ / , $pt);
        if(0 == $click_flag)
        {
            if(($min_dim > 1) && ($x != 0) & ($y != 0))
            {
                $graph[$y][$x] = 'c';
                $click_flag = 1;
                next;
            }
        }
        $graph[$y][$x] = '.';
    }


    for(my $i = 0; $i < $R; $i++)
    {
        for(my $k = 0; $k < $C; $k ++)
        {
            print $graph[$i][$k]; 
        }
        print "\n";
    }
    
    
}

sub find_iden
{
    my ($elem , $arr , $len) = @_;
    for(my $i = 0; $i < $len; $i++)
    {
        if($$arr[$i] eq $elem)
        {
            return 1;
        }
        next;
    }
    return 0;
}

sub find_neighbor
{
    my ($R , $C , $point) = @_;
    my @coord = split(/ / , $point);
    my $x = $coord[0];
    my $y = $coord[1];
    #print "This is x $x , this is y $y \n";
    my $x_plus = (($x + 1) >= $C)? ($C - 1) : ($x + 1);
    my $x_minus = (($x - 1) <= -1) ? 0 : ($x - 1);
    my $y_plus = (($y + 1) >= $R) ? ($R - 1) : ($y + 1);
    my $y_minus = (($y - 1) <= -1) ? 0 : ($y - 1);

    my @nei = ("$x_minus $y_minus" , "$x $y_plus" , "$x_plus $y_plus" , "$x_plus $y" , "$x_plus $y_minus" , "$x $y_minus" , "$x_minus $y_minus" , "$x_minus $y");
    @nei = uniq @nei;
    foreach my $nei_t (@nei)
    {
        #print "These are neighbors $nei_t\n";
    }
    return @nei;
}

sub init_array
{
    my ($R , $C , $source_arr) = @_;
    for(my $i = 0; $i < $R; $i++)
    {
        for(my $k = 0; $k < $C; $k ++)
        {
            $$source_arr[$i][$k] = '*';
        }
    }
}
