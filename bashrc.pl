#!/usr/bin/perl -w
#!/usr/bin/perl -w -d:ptkdb
{
use strict;

# usage is: bashrc.pl KEY
#
# KEY is a key for the file to be modified, defaults to BASHRC
#
use List::MoreUtils qw(firstidx);

our @lines;

my $eol = "\n";

my $file;
my $lastline;

my %files = (
  BASHRC => [ "$ENV{HOME}/.bashrc",
    'history', # match line to be inserted before
    <<EOF,
alias mc='. /usr/lib/mc/mc-wrapper.sh'
alias sudo='sudo -E'
alias cp='cp -a'
export TERM=xterm-256color # for mate-terminal which corrupts it
EOF
  ],
  PROFILE => [ "$ENV{HOME}/.profile",
    'private',
    <<'EOF',
export COLORTERM=truecolor # für mc
export EDITOR=gvim # für mc
if test -n "$GDMSESSION" 
then
  hostname | grep 'HP-Laptop' && export MC_SKIN=seasons-winter16M.ini
else
  export MC_SKIN=/home/horst/.mc/skins/default.ini # path search not working
fi
umask 002
EOF
  ],
); # files

# bei mate kein xterm vorhanden.
# wird aber benötigt um etwa mc vom Desktop zu starten
# PATH wird in $HOME/.profile gesetzt
# wiederum gerufen von login und auch vom mate desktop

my $localstring = "### local modifications";
my $localbegin = $localstring . " - BEGIN";
my $localend = $localstring . " - END";

sub search {
  my ($re1, $re2, $re3) = @_;
  # search in @lines for re1 .. re2 or re3
  # returns ($ib, $ia)
  # aborts if neither is found

  # my $nlines = $#$rl; # last index of @$rl - nur zum Merken 

  my $ibegin;
  my $iend;
  if(ref($re1)) {
    $ibegin = firstidx { $_ =~ $re1 } @lines;
    if($ibegin >= 0) {
      $iend = firstidx { $_ =~ $re2 } @lines[$ibegin .. $lastline];
      die "no END found" if($iend < 0);
      return ($ibegin - 1, $ibegin + $iend + 1);
    } # if
  } # if

  if(ref($re3)) {
    $ibegin = firstidx { $_ =~ $re3 } @lines;
    die qq(not found: "$re3") if($ibegin < 0);
    return ($ibegin - 1, $ibegin);
  } # if
  
  die "cannot modify $file";
} # search

my $key;
{no warnings; $key = uc($ARGV[0]) || "BASHRC"};
exists($files{$key}) or die "nothing known about $key";
my $key2 = $files{$key};
$file = $key2->[0];

open(my $fh, '+<', $file) or die;
@lines = <$fh>;
$lastline = $#lines;

my ($ib, $ia) = search(qr/$localbegin/, qr/$localend/, qr/$key2->[1]/);

# before and after match

# print "$ib $ia", $eol; exit;

seek $fh, 0, 0;
truncate $fh, 0;

print $fh @lines[0 .. $ib];
print $fh $localbegin, $eol;
print $fh $key2->[2];
print $fh $localend, $eol;
print $fh @lines[$ia .. $lastline];

close $fh or die;
}
__END__
