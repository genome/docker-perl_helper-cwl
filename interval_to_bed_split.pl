#! /usr/bin/perl

#Copyright (C) 2018 Feiyu Du <fdu@wustl.edu>
#              and Washington University The Genome Institute

#This script is distributed in the hope that it will be useful, 
#but WITHOUT ANY WARRANTY or the implied warranty of 
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
#GNU General Public License for more details.


use strict;
use warnings;

use feature qw(say);

die "Provide output dir, interval list and scatter count" unless @ARGV == 3;
my ($out_dir, $interval_list, $scatter_ct) = @ARGV;

chomp(my $total_ct = `/bin/grep -c -v "^@" $interval_list`);

my $split_number = sprintf("%d", $total_ct/$scatter_ct) + 1;

open(my $fh, $interval_list) or die "fail to open $interval_list for read";

my @splits;
my $split_ct = 0;
my $line_ct  = 0;

while (<$fh>) {
    next if /^@/;
    my ($chr, $start, $stop) = split /\t/, $_;
    $start = $start-1;
    push @splits, $chr."\t".$start."\t".$stop;
    $line_ct++;
    write_split_file() if $line_ct == $split_number;
}
close $fh;        

write_split_file() if @splits;

sub write_split_file {
    $split_ct++;
    my $out_file = $out_dir.'/'.$split_ct.'.interval.bed';
    open(my $split_fh, ">$out_file") or die "can't write to $out_file\n";
    map{say $split_fh $_}@splits;
    close $split_fh;
    $line_ct = 0;
    @splits=();
}

