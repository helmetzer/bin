use strict;
#
package Abr;

sub suche
{
    my($rlines, $qr, $count) = @_;

    my @ret = ();
    my $cc = 0;

    LINES: for my $line (@$rlines)
    {
        next LINE unless $line =~ $qr;
        push @ret, $1;
        $cc++;
        last LINE if $cc >= $count;
    } # LINES
    return @ret;

} # suche
1;
__END__
