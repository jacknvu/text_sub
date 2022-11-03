#!/usr/bin/perl

# script reads 2 files:
#  key/value file and datafile
#  make key/value substitution in datafile and print line

use strict;

my %kv_h;

my $kvfile;
my $datafile;

#
# get keyvalue file name
# get datafile name
#
sub read_input_args()
{
	($kvfile, $datafile) = @ARGV;
	if (not defined $datafile) {
		print "Usage:  keyvaluefile datafile\n";
		exit (1);
	}
}

#
# read key/value file (file1)
#
sub open_file1()
{
	my $file1=$kvfile;
	open (FILE1, "< $file1") or die ("can't open file $file1: $!");
	print ("\nopening $file1 ...\n");
	while (<FILE1>) {
		#print;
		my ($k, $v) = split; 	#note: key value line
		$k =~ s/\[/\\\[/;	#handle square bracket [
		$k =~ s/\]/\\\]/;	#handle square bracket  ]
		if (not defined $kv_h{$k}) {
			$kv_h{$k} = $v;
		} else {
			print "error: line $., key/value exist:  $k => $kv_h{$k}, skipping this"
		}
	}
}

#
# read datafile (file2) and make key/value substition
#
sub open_file2()
{
	my $file2=$datafile;
	open (FILE2, "< $file2") or die ("can't open $file2: $!");
	print ("\nopening $file2 ...\n");
	while (<FILE2>) {
		#print "Before: LINE $. : $_";
		foreach my $key (keys(%kv_h)) {
			#print "$key => $kv_h{$key}\n";
			if (/$key/) {				
				s/$key/$kv_h{$key}/g;	#make substitution, global sub. on single line
			}
		}
		#print "After: LINE $. : $_";
		print ;					#print line with substitution
	}
}

#----------
# main()
#----------
read_input_args();

open_file1();

#foreach my $key (keys(%kv_h)) {
	#print "$key => $kv_h{$key}\n";
#}

open_file2();

