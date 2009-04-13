#! /usr/bin/perl -w
use strict;
my $in = shift;

my @center;
my @offset;
my $horiz = shift;
my $vert = shift;

my @map;
my $maxx = 0;
my $maxy = 0;
my @corr;
my $obs = 0;
my $total_contacts = 0;
my $total_cells = 0;

#print "$in\n";
open (IN, "<$in") or die;
<IN>;
# Read in a protein
while (<IN>) {
#	print;
	my ($x, $y, $t, $p) = $_ =~ /(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/;

	# 0 = truth, 1 = prediction
	$map[$x][$y][0] = $t;
	$map[$x][$y][1] = $p;

	$maxx = $x if ($x > $maxx);
	$maxy = $y if ($y > $maxy);
}
close (IN);

# Check the correlation with some step
for (my $x = 0; $x <= $maxx; $x++) {
	for (my $y = 0; $y <= $maxy; $y++) {
		if (defined $map[$x][$y][0] and defined $map[$x+$horiz][$y+$vert][0]) {
			$obs += $map[$x][$y][0] * $map[$x+$horiz][$y+$vert][0];
			#print STDOUT "",($map[$x][$y][0] + $map[$x+$horiz][$y+$vert][0]),"\t",($map[$x][$y][1] + $map[$x+$horiz][$y+$vert][1]),"\n";
			print STDOUT "",$map[$x][$y][0] ,"\t", $map[$x+$horiz][$y+$vert][0],"\t",$map[$x][$y][1] ,"\t", $map[$x+$horiz][$y+$vert][1],"\n";
			push(@corr,$map[$x][$y][1] * $map[$x+$horiz][$y+$vert][1]);

			$total_contacts += $map[$x][$y][0];
			$total_cells++;
		}
	}
}	

my $prob_contact = $total_contacts/$total_cells;
my $expect = $prob_contact ** 2 * $total_cells;

print STDERR "$total_contacts\t$total_cells\t$obs\t\n";
