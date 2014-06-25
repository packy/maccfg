#!/bin/bash

xtitle () { printf "\e]0;%s\007" "$1"; }

xsize () {
    HEIGHT=${1:-"50"};
    WIDTH=${2:-"80"};
    printf "\e[8;%d;%dt" $HEIGHT $WIDTH;
}

xprofile () {
    PROFILE=${1:-"Default"};
    printf "\e]50;SetProfile=%s\a" "$PROFILE";
}

tlily () {
    xprofile tlily
    xsize 70 80
    xtitle 'packy @ RPI'; /usr/local/bin/tlily
}


authorize () {
  HOSTNAME=$(hostname -s)
  USER=$(whoami)
  REMOTE_PUB=.ssh/id_rsa_${HOSTNAME}_${USER}.pub
  scp ~/.ssh/id_rsa.pub $1@$2:$REMOTE_PUB
  ssh $1@$2 "cat ~/$REMOTE_PUB >> ~/.ssh/authorized_keys"
}

forget_host () {
  TMP=/tmp/known_hosts.$$
  grep -v $1 $HOME/.ssh/known_hosts > $TMP
  mv $TMP $HOME/.ssh/known_hosts
}

unshift_path () {
  export PATH=$(/usr/bin/perl -e '
    my $sep  = q{:};
    my $alt  = join q{|}, @ARGV;
    my $add  = qr/^(?:$alt)$/;
    # get the dirs in $PATH that are not being put on the front
    my @PATH = grep { !/$add/ } split /$sep/, $ENV{PATH};
    print join $sep, @ARGV, @PATH;
  ' $*)
}


push_path () {
  export PATH=$(/usr/bin/perl -e '
    my $sep  = q{:};
    my $alt  = join q{|}, @ARGV;
    my $add  = qr/^(?:$alt)$/;
    # get the dirs in $PATH that are not being put on the end
    my @PATH = grep { !/$add/ } split /$sep/, $ENV{PATH};
    print join $sep, @PATH, @ARGV;
  ' $*)
}

explode_path () {
  /usr/bin/perl -e '
    my $PATH  = $ENV{PATH};
    my $sep   = q{:};
    my @parts = split /$sep/, $PATH;
    print "  ", join("\n  ", @parts), "\n";
  '
}

uniq_path () {
  export PATH=$(/usr/bin/perl -e '
    my $sep  = q{:};
    my %seen;
    my @PATH = grep { ! $seen{$_}++ } split /$sep/, $ENV{PATH};
    print join $sep, @PATH, @ARGV;
  ' $*)
}

