#! /usr/bin/perl -w
use strict;

my $in = shift;
my $out = shift;

open (OUT, ">$out") or die;
foreach (system('ls' . $in . '/*.crf') {
	chomp;
	open (IN, "<$_") or die;
	<IN>;
	while (<IN>) { print OUT; }
	close (IN);
}
close (OUT);

