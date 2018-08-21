#!/usr/bin/perl -w

use strict;

# print "@ARGV\n"; exit;

my $in = $ARGV[0];
my $out;

{ my $i = 0; do {$out = "$in.$i"; $i++} while -e $out };

print "using temporary file $out\n";

open(my $fhin, "<", $in)
    or die "cannot open $in: $!";

open(my $fhout, ">", $out)
    or die "cannot open $out: $!";

while(my $line = <$fhin>) {
    chomp $line;
    $line =~ s/\r+$//;
    print $fhout $line, "\n";
}

close $fhout or die "cannot close $out: $!";
close $fhin;

unlink($in) or die "cannot unlink $in: $!";
link($out, $in) or die "cannot link($out, $in):$!";
unlink($out) or die "cannot unlink $out: $!";

exit;
__END__
