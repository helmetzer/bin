#!/usr/bin/perl -w
#
# Einlesen einer Wertpapierabrechnung von Scalable
# Vorher umwandeln: pdftotext foo.pdf
# Synopsis: cmd.pl file ...
use strict;
# use re 'strict';


{
    our $n = "\n";
    our $depot = "5177528274";

    my $fh;
    my $file;

    my $regisin = qr/^[A-Z0-9]{12}$/ ;
    my $regtag = qr/^(.*) \d\d:\d\d:\d\d/ ;
    my $reganzahl = qr/^([\d,]+) Stk\./ ;
    my $regpreis = qr/^([\d,]+) EUR/ ;

    FILE: while($file = shift)
    {
        open($fh, $file) or die;
        my @lines = <$fh>;
        my $found;
        my $typ;
        LINE: for my $line (@lines)
        # ignorieren, wenn Depotnummer nicht gefunden
        {
            $found = index($line, $depot) >= 0 and last LINE;
        } # LINE

        unless($found)
        {
            print "uebersprungen 1: ", $file, $n;
            next FILE;
        }

        # ignorieren, wenn Wertpapierabrechnung nicht gefunden
        LINE: for my $line (@lines)
        {
            $typ = "Kauf";
            $found = index($line, $typ) == 0
                and last LINE;
            $typ = "Verkauf";
            $found = index($line, $typ) == 0
                and last LINE;
        } # LINE

        unless($found)
        {
#           print "uebersprungen: ", $file, $n;
            next FILE;
        }
#       Suche nach diversen Merkmalen
        my $count = 0;
        my ($tag, $anzahl, $preis, $isin);
        LINE: for my $line (@lines)
        {
            if($line =~ $regtag)
            {
                $tag = $1;
                $count++;
            }
            elsif($line =~ $reganzahl)
            {
                $anzahl = $1;
                $count++;
            }
            elsif($line =~ $regisin)
            {
                chop($isin = $line);
                $count++;
            }
            elsif(not $preis and $line =~ $regpreis)
            {
                $preis = $1;
                $count++;
            }
            last LINE if $count == 4;
        } # LINE
        $anzahl = "-$anzahl" if $typ eq "Verkauf";
        print(join(";", $tag, $anzahl, $preis, $typ,
                $isin, $depot, $file, $n));

    } # FILE
}

__END__
