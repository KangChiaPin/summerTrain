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

open FH, ">whole_data";
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

open FH, ">train_data";
for(0 .. ($#raw_data/2)){
	@tmp = split /,/, $raw_data[$_];
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

open FH, ">predict_data";
for(($#raw_data/2 + 1) .. $#raw_data){
	@tmp = split /,/, $raw_data[$_];
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

`./svm-scale -s train_scale_model train_data > train_data.scale`;
`./rvkde --best --cv --classify -n 5 -v train_data.scale > train_result`;
`./svm-scale -s predict_scale_model predict_data > predict_data.scale`;
`./rvkde --best --predict --classify -v train_data.scale -V predict_data.scale > predict_result`;
