#!/usr/bin/perl -w
#
# Einlesen einer Wertpapierabrechnung
# Vorher umwandeln: pdftotext foo.pdf
# Synopsis: cmd.pl file ...
use strict;

{
    our $n = "\n";
    our $depot = "1242496";
    my $fh;
    my $file;

    FILE: while($file = shift)
    {
        open($fh, $file) or die;
        my @lines = <$fh>;
        my $found;
        my $typ;
        LINE: for my $line (@lines)
        # ignorieren, wenn Depotnummer nicht gefunden
        {
            next LINE unless $found = index($line, "Stamm-Nr") >= 0;
            $found = index($line, $depot) >= 0;
            last LINE;
        } # LINE

        unless($found)
        {
            print "uebersprungen: ", $file, $n;
            next FILE;
        }

        # ignorieren, wenn Wertpapierabrechnung nicht gefunden
        LINE: for my $line (@lines)
        {
            $found = index($line, "Wertpapierabrechnung:") == 0
                and $typ = substr($line, 22, -1) and last LINE;
        } # LINE

        unless($found)
        {
#           print "uebersprungen: ", $file, $n;
            next FILE;
        }
#       Suche nach diversen Merkmalen
        my $count = 0;
        my $reg = qr/^[,\d]+$/ ;
        my ($tag, $anzahl, $preis, $isin);
        LINE: for my $line (@lines)
        {
            if(index($line, "Auftragsdatum") == 0)
            {
                $tag = substr($line, 15, 10);
                $count++;
            }
            elsif(index($line, "STK") == 0)
            {
                $anzahl = substr($line, 4, -1);
                $count++;
            }
            elsif(index($line, "ISIN") == 0)
            {
                $isin = substr($line, 6, 12);
#               print $line, $isin, $n;
                $count++;
            }
            elsif(not $preis and $line =~ $reg)
            {
                chop($preis = $line);
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
