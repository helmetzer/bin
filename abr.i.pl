#!/usr/bin/perl -w
#
# Einlesen einer Wertpapierabrechnung von ING
# Vorher umwandeln: pdftotext foo.pdf
# Synopsis: cmd.pl file ...
use strict;
# use re 'strict';
use abr;

{
    our $n = "\n";
    our @Depots = qw(8010194141 8305449430 8031358819 8771508130
         8009145655 8012452127);
    my $depot;

    my $fh;
    my $file;

    my $regdepot = qr/^([0-9]{10})$/ ;
    my $regisin = qr/^([A-Z0-9]{12}) \(/ ;

    my $regtag = qr/^(.*) um \d\d:\d\d:\d\d/ ;
    my $reganzahl = qr/^([\d,]+)$/ ;
#   my $regpreis = qr/^([\d,]+) EUR/ ;

    FILE: while($file = shift)
    {
        open($fh, $file) or die;
        my @lines = <$fh>;
        my $found;
        my $typ;
        LINE: for my $line (@lines)
        # ignorieren, wenn Depotnummer nicht gefunden
        {
            $found = $line =~ $regdepot and 
                $depot = $1 and last LINE;
        } # LINE
        
        $found &= grep($_ eq $depot, @Depots);

        unless($found)
        {
            print STDERR ("uebersprungen 1: ", $file, $n);
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
            print STDERR ("uebersprungen 2: ", $file, $n);
            next FILE;
        }
#       Suche nach diversen Merkmalen
        my $count = 0;
        my ($tag, $anzahl, $preis, $isin);
        my @zahlen = ();
        LINE: for my $line (@lines)
        {
            if($line =~ $regtag)
            {
                $tag = $1;
                $count++;
            }
            elsif($line =~ $reganzahl and @zahlen < 2)
            {
                push(@zahlen, $1);
                $count++;
            }
            elsif($line =~ $regisin)
            {
                $isin = $1;
                $count++;
            }
            last LINE if $count == 4;
        } # LINE
        ($anzahl, $preis) = @zahlen[0..1];
        $anzahl = "-$anzahl" if $typ eq "Verkauf";
        print(join(";", $tag, $anzahl, $preis, $typ,
                $isin, $depot, $file, $n));

    } # FILE
}

__END__
