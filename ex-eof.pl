#!/usr/bin/perl -w

use strict;

# gibt alle files in der Kommandozeile auf STDOUT aus
# nach jedem file wird eine Zeile --- ausgegeben.

while (<>) {
    print;
    print "---\n" if eof;
} # while
__END__
