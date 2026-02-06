#!/usr/bin/perl -w
#

use strict;

{
    my $some_dir = ".";
    my $n = "\n";

    opendir(my $dh, $some_dir) || die "Can't opendir $some_dir: $!";
#   my @dots = grep { /^\./ && -f "$some_dir/$_" } readdir($dh);
    my @dots = readdir($dh);
    closedir $dh;

    for (@dots)
    {
        my $new = $_;
        next unless $new =~tr/ /_/;
        link($_, $new) or next;
        unlink $_;
#       print $_, " ", $new, $n;
    }

}

__END__
