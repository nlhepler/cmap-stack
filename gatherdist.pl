#! /usr/bin/perl -w
use strict;

my $out = shift;

open (OUT, ">$out") or die;
foreach (`ls marcopunta/*.crf`) {
	chomp;
	open (IN, "<$_") or die;
	<IN>;
	while (<IN>) { print OUT; }
	close (IN);
}
close (OUT);

