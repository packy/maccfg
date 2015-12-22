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
  DIR="~/.ssh"
  REMOTE_PUB="~/.ssh/id_rsa_${HOSTNAME}_${USER}.pub"
  AUTH_KEYS="~/.ssh/authorized_keys"
  cat ~/.ssh/id_rsa.pub | ssh $1@$2 "umask 077; test -d $DIR || mkdir $DIR; cat > $REMOTE_PUB; cat $REMOTE_PUB >> $AUTH_KEYS; test -x /sbin/restorecon && /sbin/restorecon $DIR $REMOTE_PUB $AUTH_KEYS" || exit 1
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

7zarc () {
    for DIR in $*; do
        7z a -t7z -mx=9 -m0=lzma -mfb=64 -md=32m -ms=on $DIR.7z $DIR
        trash $DIR
        mkdir -p old/
        mv $DIR.7z old/
    done
}

