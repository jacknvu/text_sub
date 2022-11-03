#!/usr/bin/perl

use strict;

my %kv_h; 

sub open_file1()
{
	my $file1='file1';
	open (FILE1, "< $file1") or die ("can't open $file1: $!");
	print ("opening $file1 ...\n");
	while (<FILE1>) {
		#print;
		my ($v, $k) = split;
		$kv_h{$k} = $v;
	}
}

sub open_file2()
{
	my $file2='file2';
	open (FILE2, "< $file2") or die ("can't open $file2: $!");
	print ("opening $file2 ...\n");
	while (<FILE2>) {
		foreach my $key (keys(%kv_h)) {
			#print "$key => $kv_h{$key}\n";
			if (/$key/) {
				s/$key/$kv_h{$key}/;
			}
		}
		print;
	}
}

#----------
# main()
#----------

open_file1();

foreach my $key (keys(%kv_h)) {
	print "$key => $kv_h{$key}\n";
}

open_file2();

