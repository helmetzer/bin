#!/usr/bin/perl -w -d:ptkdb
#!/usr/bin/perl -w
#
# Findet alle mp3-Dateien in Unterverzeichnissen
#

use strict;
use File::Find;
use MP3::Tag;

our $dir1 = "$ENV{HOME}/Musik";

chdir($dir1) or die "Cannot chdir to $dir1";

our $l1 = length($dir1);
our $dir2 = "D:/Music/";
# our $dir2 = "//MORITZ/MusikAlterRe/";

sub wanted {

    my $file1 = $File::Find::name;
    return if(-d $file1);
    return unless $file1 =~ /\.mp3$/i;
    my $mp3 = MP3::Tag->new($_);
    my ($title, $track, $artist, $album, $comment, $year, $genre) = $mp3->autoinfo();
    my $length = $mp3->time_mm_ss();
 
    print join(";", substr($file1, 2), $artist, $album, $title ,$length, "\n");
#    exit;

} # wanted

{

find(\&wanted, ".");
}
__END__
