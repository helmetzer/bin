use strict;
#
package Abr;

sub suche
{
    my($rlines, $qr, $count) = @_;

    my @ret = ();
    my $cc = 0;

    LINE: for my $line (@$rlines)
    {
        next LINE unless $line =~ $qr;
        push @ret, $1;
        $cc++;
        last LINE if $cc >= $count;
    } # LINE
    return $count == 1 ? $ret[0] : @ret;

} # suche
1;
__END__
