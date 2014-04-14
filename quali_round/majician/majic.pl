#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: majic.pl
#
#        USAGE: ./majic.pl  
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
#      CREATED: 04/12/2014 07:25:01
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

open(INP , 'input') or die "Failed to read the data $!\n"; 


my $case_cnt = 0;
my $case_num = 0;
my $line_cnt = 0;
my @case_content; 

while(<INP>)
{
    $line_cnt ++;
    #print "The line count is $line_cnt\n";
    if(1 == $line_cnt)
    {
        $_  =~ m/(\d+)/ ;
        $case_cnt = $1;
        #print "This is the case number $case_cnt";
        next;
    }
    chomp;
    #print "$_\n";
    push(@case_content , $_);
}

#print $case_cnt;

close(INP);


my $case_start_index = 0;
my $case_2nd_start_index = 5;
my $pace = 10;

for(my $i = 0; $i < $case_cnt; $i++)
{
    $case_num = $i + 1;
    my $offset = $i * $pace;
    my $case_start_index = $case_start_index + $offset;
    my $case_2nd_start_index = $case_2nd_start_index + $offset;

    my $guess1 = $case_content[$case_start_index];
    my $guess2 = $case_content[$case_2nd_start_index];


    my $guess1_line = $case_content[$case_start_index + $guess1];
    my $guess2_line = $case_content[$case_2nd_start_index + $guess2]; 


    #print "This is the guess1 line $guess1_line\n";
    #print "This is the guess2 line $guess2_line\n";
    my @line1 = split(/ / , $guess1_line);
    my @line2 = split(/ / , $guess2_line);

    my $result = 0;
    my $guess_num = -1;

    for(my $k = 0; $k < 4; $k ++)
    {
        my $num = $line1[$k];
        for(my $s = 0; $s < 4; $s++)
        {
            if($num == $line2[$s])
            {
                $guess_num = $num;
                $result ++;
            }
        }
    }


    if(0 == $result)
    {
        print "Case #$case_num: Volunteer cheated! \n";
    }
    elsif ($result > 1)
    {
        print "Case #$case_num: Bad magician!\n";
    }
    elsif (1 == $result)
    {
        print "Case #$case_num: $guess_num\n";
    }
}

