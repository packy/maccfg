#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

use File::Spec::Functions;

my $config = catfile $ENV{HOME}, '.atom', 'config.cson';

if ( -e $config) {
  open my $fh, '<', $config;
  my $found;
  while (my $line = <$fh>) {
    $found = $line =~ /sync-settings/;
    last if $found;
  }
  close $fh;
  if ($found) {
    say "Atom sync-settings package already configured.";
    exit;
  }
}
say "Configuring Atom sync-settings package...";

my $token;
my $gist;
while (1) {
  print "Personal Access Token: ";
  $token = <>;
  chomp $token;

  print "Gist ID: ";
  $gist = <>;
  chomp $gist;

  say qq{    personalAccessToken: "$token"};
  say qq{    gistId: "$gist"};

  print "Is this correct? (y/N) ";
  my $yorn = <>;
  chomp $yorn;
  last if lc($yorn) eq 'y';
}

my $fh;
if ( -e $config) {
  open $fh, '>>', $config;
}
else {
  open $fh, '>', $config;
  say $fh qq{"*":};
}

say $fh qq{  "sync-settings":};
say $fh qq{    gistId: "$gist"};
say $fh qq{    personalAccessToken: "$token"};

close $fh;
