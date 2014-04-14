#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: deceit_war.pl
#
#        USAGE: ./deceit_war.pl  
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
#      CREATED: 04/12/2014 15:18:08
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;


open(FILE , 'input') or die "Failed to open the file $!\n";

my @case_content = <FILE>;

close(FILE);


my $case_cnt = shift(@case_content);


my $offset = 3;

for(my $i = 0; $i < $case_cnt; $i ++)
{
    my $case_num = $i + 1;
    chomp($case_content[0 + $i * $offset]);
    chomp($case_content[1 + $i * $offset]);
    chomp($case_content[2 + $i * $offset]);

    my $block_num = $case_content[0 + $i * $offset];
    my @naomi_block = split(/ / , $case_content[1 + $i * $offset]);
    my @ken_block = split(/ / , $case_content[2 + $i * $offset]);

    
    #sortArr(\@naomi_block , $block_num);
    #sortArr(\@ken_block , $block_num);
    @naomi_block = sort {$a <=> $b} @naomi_block;
    @ken_block = sort {$a <=> $b} @ken_block;

    foreach my $naomi (@naomi_block)
    {
        #print "This is naomi $naomi \n";
    }
    foreach my $ken (@ken_block)
    {
        #print "This is ken $ken \n";
    }


    #calculate the max ken
    my $ken_max = 0;
    my @temp_naomi = @naomi_block;
    for(my $s = $block_num - 1; $s > -1; $s --)
    {
        my $act_len = $block_num - $ken_max;
        for(my $k = $act_len - 1 ; $k > -1; $k --)
        {
            if(($ken_block[$s] > $temp_naomi[$k]) && ($temp_naomi[$k] != 0))
            {
                $ken_max ++;
                $temp_naomi[$k] = 0;
                last;
            }
        }
    }

    my $naomi_war = $block_num - $ken_max;
    



    #calculate the max naomi
    my $naomi_de_war = 0;
    my @temp_ken = @ken_block;
    for(my $t = $block_num - 1; $t > -1 ; $t --)
    {
        my $naomi_block_mass = $naomi_block[$t];
        my $act_len = $block_num - $naomi_de_war;
        for(my $k = $act_len - 1; $k > -1; $k --)
        {
            if( ($naomi_block_mass > $temp_ken[$k]) && ($temp_ken[$k] != 0))
            {
                $naomi_de_war ++;
                $temp_ken[$k] = 0;
                last;
            }
        }
    }

    print "Case #$case_num: $naomi_de_war $naomi_war\n";

}


sub sortArr
{
    my ($source_array , $len) = @_;

    for(my $i = 0; $i < $len - 1; $i ++)
    {
        if($$source_array[$i] > $$source_array[$i + 1])
        {
            my $temp = 0;
            $temp = $$source_array[$i];
            $$source_array[$i] = $$source_array[$i + 1];
            $$source_array[$i + 1] = $temp;
        }
    }
}
