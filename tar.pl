#!/usr/bin/perl -w

use strict;

use Getopt::Long;

# print "@_\n"; exit;

my $eol = "\n";

my $full = '';
my $test = '';

my $host = qx(hostname);
# print( $host, length($host), $eol); exit;
my $IsHP = $host =~ /HP/;
chomp $host;
my $IsDebian = $host eq "debian";

my %TarJobs = (
    etc => {
        BASEDIR => "/",
        TOTAR => [ "etc", ],
    },
    home => {
        BASEDIR => $ENV{HOME},
        TOTAR => [ ".", ],
    },
    daten => {
        BASEDIR => "/daten/Users/horst",
        TOTAR => [ "Dokumente", "eBooks", 
          "mozilla", ".thunderbird",
#         $IsHP ? () : "Repository", 
              ],
    },
#    bettina => {
#        BASEDIR => "/daten/Users/Bettina",
#        TOTAR => [ ".", ],
#    },
#    },
);

my $TarDir = $IsHP ?
   "/daten/Users/horst/Sicherung/Mint20" :
   "/daten/Users/horst/Sicherung/Mint20";

   # print( $TarDir, $eol); exit;
if($IsDebian) {
   delete $TarJobs{daten};
   $TarDir = "/Sicherung";
} 

my $tsSuffix = ".ts";

sub getLastFullDump() {

    opendir my $Dir, $TarDir
        or die "cannot open directory $TarDir: $!";

    my @Files = readdir $Dir
        or die "cannot read directory $TarDir: $!";

#    print "@Files\n";

    @Files = grep { /(.*)\Q$tsSuffix\E$/o } @Files;

    @Files = sort { $a cmp $b } @Files;

    return $Files[-1];
} # getLastFullDump

sub create {
    my($file) = @_;

    open(my $fh, ">", $file)
        or die "cannot open file $file: $!";
    close($fh)
        or die "cannot close file $file: $!";
} # create

my $ts = time();

GetOptions("full" => \$full,
           "test" => \$test,
       );

my $tsFile = '';

unless($full) {
    unless($tsFile = getLastFullDump()) {
        $full = 1;
        print "No previous full dump found, forcing full dump\n";
    } else {
        print "Latest full dump found: $tsFile\n";
    } 
}

if($full) {
    $tsFile = "$TarDir/$ts$tsSuffix";
    create($tsFile);
} else {
    $tsFile = "$TarDir/$tsFile";
}

print "$tsFile\n";

for (keys %TarJobs) {
    my $base = $TarJobs{$_}{BASEDIR};
    unless(chdir($base)) {
        warn("cannot chdir to $base: $!");
        next;
    } # unless
    my $TarName = "$TarDir/"
        .join(".", $_, $ts, $full ? "full" : "diff", "tgz");
    my @Tars = qw(tar -cvzf);
 #   push(@Tars, $TarName, "--exclude", "Alt", "--exclude", "VirtualBox VMs");
    push(@Tars, $TarName, "--exclude", "tmp", 
     "--exclude", "Alt", "--exclude-tag", "CACHEDIR.TAG");
    push(@Tars, "--newer", $tsFile) unless ($full);
    push(@Tars, @{$TarJobs{$_}{TOTAR}});
    unshift @Tars, qw(echo) if($test);
    #    print ("@Tars", "\n"); exit;  # TEST
    print ((system @Tars), "\n");
} # for

# push @Tars, "$TarDir/$TarName", ".";

__END__
