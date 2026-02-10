#!/usr/bin/perl -w
#!/usr/bin/perl -w -d:ptkdb
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
         8009145655 8012452127 8751936930 8011518021);
    my $depot;

    my $fh;
    my $file;

    my $regdepot = qr/^([0-9]{10})$/ ;
    my $regtyp = qr/\b(Kauf|Verkauf|Eingang|Ausgang|entgeltlichen)\b/ ;
    my $regorder = qr/\b(Order)\b/ ;
    my $regisin = qr/^([A-Z0-9]{12}) \(/ ;

    my $regtag = qr/^(.*) um \d\d:\d\d:\d\d/ ;
    my $regtague = qr/^(\d\d\.\d\d\.20\d\d)$/ ;
    my $reganzahl = qr/^([\d,]+)$/ ;
    my $regstk = qr/^([\d,]+) St.+ck$/ ; # Unicode ?

    FILE: while($file = shift)
    {
        open($fh, $file) or die;
        my @lines = <$fh>;
        my $rlines = \@lines;
        my $found;
        my $typ;


        $depot = Abr::suche($rlines, $regdepot, 1);

        $found = defined $depot;

        # ignorieren, wenn Depotnummer nicht gefunden

        
        $found &= grep($_ eq $depot, @Depots);

        unless($found)
        {
            print STDERR ("uebersprungen 1: ", $file, $n);
            next FILE;
        }

        # ignorieren, wenn Wertpapierabrechnung nicht gefunden
        $typ = Abr::suche($rlines, $regtyp, 1);
        $found = defined $typ;
        if($typ eq "Kauf")
        {
            Abr::suche($rlines, $regorder, 1) and next FILE;
        }

        unless($found)
        {
            print STDERR ("uebersprungen 2: ", $file, $n);
            next FILE;
        }
#       Suche nach diversen Merkmalen
        my ($tag, $anzahl, $preis, $isin);
        my @zahlen;
        $isin = Abr::suche($rlines, $regisin, 1);
        $tag = Abr::suche($rlines, $regtag, 1);
        if(not defined $tag)
        {
            @zahlen = Abr::suche($rlines, $regtague, 2);
            $tag = $zahlen[1];
        }
        @zahlen = Abr::suche($rlines, $reganzahl, 2);
#       print "Zahlen:@zahlen", $n;
        if($zahlen[0] =~ $regdepot) # falsch das war die Depotnr.
        {
            $anzahl = Abr::suche($rlines, $regstk, 1);
            $preis = "";
        } else {
            ($anzahl, $preis) = @zahlen[0..1];
        }
        $anzahl = "-$anzahl" if $typ eq "Verkauf"
            or $typ eq "Ausgang" or $typ eq "entgeltlichen";
        print(join(";", $tag, $anzahl, $preis, $typ,
                $isin, $depot, $file, $n));

    } # FILE
}

__END__
