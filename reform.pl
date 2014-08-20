#!/usr/bin/perl -w
use strict;
use YAML;

open FH, "table.csv";
<FH>;
my @raw_data = <FH> or die "not found";
close FH;

my @tmp;
my $close;
my $change;

sub AD{
	(($_[4] - $_[3]) - ($_[2] - $_[4])) * ($_[5] / ($_[2] - $_[3])) + $_[6];
}

sub CCI{
	
}

#print &AD((1,2,3,4,5,6),7);

my $AD;

open FH, ">trainer";
foreach my $token(@raw_data){
	#print $token;
	@tmp = split /,/, $token;
	chomp @tmp;
	$AD = &AD(@tmp,$AD);
	if($close){
		$change = ($close - $tmp[4])>0 ? 1 : -1;
		print FH "$change\t1:$tmp[1]\t2:$tmp[2]\t3:$tmp[3]\t4:$tmp[4]\t5:$tmp[5]\t6:$tmp[6]\n";
	}
	else{
		$AD = &AD(@tmp,0);	
	}
	$close = $tmp[4];
}
close FH;
#print Dump @data;
