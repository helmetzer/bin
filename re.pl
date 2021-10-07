#!/usr/bin/perl -w

use strict;

my $s = "Hello world ello\n";
print $s;
print "matched\n" if $s =~ /\bello/;
__END__
