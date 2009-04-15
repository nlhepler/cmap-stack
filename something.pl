#!/usr/bin/perl -w

use strict;

my $SIZE = 10000;

my $in = shift;

open(FH, "<$in") or die ("Ug! dead. $in");

open(WR, ">output.in") or die ("Ug! dead. output.in");

my @ones = ();
my @zers = ();

while(<FH>) {
	my $line = $_;
	chomp($line);
	my ($val, $r) = $line =~ /(\d+)\t(.+)/;
	if ($val == 1) { push(@ones, $r); }
	elsif (scalar @zers < ($SIZE/2) ) { push(@zers, $r); }
	last if (scalar @ones >= ($SIZE/2) );
}

close(FH);

while(@ones) {
	while(@zers) {
		last if (int(rand(2)));
		print WR "0\t".pop(@zers)."\n";
	}
	print WR "1\t".pop(@ones)."\n";
}
while(@zers) { print WR "0\t".pop(@zers)."\n"; }

close(WR);
