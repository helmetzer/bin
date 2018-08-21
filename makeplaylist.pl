#!/usr/bin/perl -w
#!/usr/bin/perl -w -d:ptkdb
#
# 
#

use strict;

our @Modes = ( [ "", "", ], [ "#EXTM3U\n", "#EXTINF:-1\n" ]);
our $Mode = $Modes[1];

our $dir1 = "$ENV{HOME}/Musik";
our @Files;
my $selector = 1;
my $outname;

# chdir($dir1) or die "Cannot chdir to $dir1";

@Files = <>;
chomp @Files;
{ my ($name, @files) = split /;/, shift(@Files);
$outname = "$dir1/$files[$selector].m3u"; 
}
open(my $outfh, ">", $outname)
  or die "cannot open > $outname: $!";

print $outfh $Mode->[0] or die "error printing $!";

for (@Files) {
  my($name, @flags) = split /;/, $_;
  if($flags[$selector]) {
    print $outfh $Mode->[1], $name, "\n" or die "error printing $!"
  }

} # for

close($outfh)
  or die "cannot close > $outname: $!";
exit;
__END__
