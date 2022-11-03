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
		my ($k, $v) = split; 	#note: key value line
		$k =~ s/\[/\\\[/;	
		$k =~ s/\]/\\\]/;
		$kv_h{$k} = $v;
	}
}

sub open_file2()
{
	my $file2='file2';
	open (FILE2, "< $file2") or die ("can't open $file2: $!");
	print ("opening $file2 ...\n");
	while (<FILE2>) {
		#print "Before: LINE $. : $_";
		foreach my $key (keys(%kv_h)) {
			#print "$key => $kv_h{$key}\n";
			if (/$key/) {				# note: space
				s/$key/$kv_h{$key}/g;	# note: space
			}
		}
		#print "After: LINE $. : $_";
		print ;
	}
}

#----------
# main()
#----------

open_file1();

#foreach my $key (keys(%kv_h)) {
	#print "$key => $kv_h{$key}\n";
#}

open_file2();

