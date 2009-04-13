#! /usr/bin/perl 
use strict;

my $in = shift;

my $i = 0;
foreach (system("ls", $in)) {
	chomp;
	s/\.\w+$//;
	print STDERR $_,"\n";
	`./trycut $_ > tmp$i.out`;
	open (IN, "<tmp$i.out") or die;
	my ($bp, $br, $ap, $ar, $cbp, $cbr, $cap, $car);
	while (<IN>) {
		if (/avg precision = (\d+\.\d+)  avg recall = (\d+\.\d+)/) {
			if ($bp || $br) {
				$ap = $1; $ar = $2;
			} else {
				$bp = $1; $br = $2;
			}
		}
		if (/clump precision: (\d+\.\d+), clump recall: (\d+\.\d+)/) {
			if ($cbp || $cbr) {
				$cap = $1; $car = $2;
			} else {
				$cbp = $1; $cbr = $2;
			}
		}
	}
	print "$bp\t$br\t$ap\t$ar\t$cbp\t$cbr\t$cap\t$car\n";
	undef($bp);undef($br);undef($ap);undef($ar);undef($cbp);undef($cbr);undef($cap);undef($car);
	close (IN);
	$i++;
}
