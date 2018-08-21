#!/usr/bin/perl -wp

use strict;

# prüft, ob die Eingabezeile - ohne Zeilenende - ein Palindrom ist und gibt eine Meldung aus
chomp; print qq("$_" ist ), scalar reverse eq $_ ? "" : "k",  "ein Palindrom.\n";
__END__
