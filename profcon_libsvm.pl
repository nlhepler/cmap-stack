#! /usr/bin/perl -w
use strict;
my $in = shift;

my @map;
my $maxx = 0;
my $maxy = 0;

#print "$in\n";
open (IN, "<$in") or die("Ug. $in. $!");
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
		if (defined $map[$x][$y][0] ) {
			# Print out label
			print STDOUT "$map[$x][$y][0]\t";
			my $index = 1;
			
			# Use one of the following options:
			# The following line of code is for outputting just profcon.
			#print STDOUT "1:$map[$x][$y][1]" if defined ($map[$x][$y][1]);

			# The following block is for outputting an area around the middle prediction
			for (my $i = -1; $i < 2; $i++) {
				for (my $j = -1; $j < 2; $j++) {
					print STDOUT "$index:$map[$x+$i][$y+$j][1]\t" if defined($map[$x+$i][$y+$j][1]);
					$index++;
				}
			}
			# end of block

			print STDOUT "\n";
		}
	}
}	

