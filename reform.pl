#!/usr/bin/perl -w
use strict;
use YAML;

open FH, "table.csv";
<FH>;
my @raw_data = <FH> or die "not found";
close FH;

my @tmp;

open FH, ">trainer";
my $close;
my $change;
foreach my $token(@raw_data){
	#print $token;
	@tmp = split /,/, $token;
	chomp @tmp;
	if($close){
		$change = ($close - $tmp[4])>0 ? 1 : -1;	
		print FH "$change 1:$tmp[1] 2:$tmp[2] 3:$tmp[3] 4:$tmp[4] 5:$tmp[5] 6:$tmp[6]\n";
	}
	$close = $tmp[4];
}
close FH;
#print Dump @data;
