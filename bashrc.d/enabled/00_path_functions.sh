#!/usr/bin/env bash
# for syntax highlightling in emacs, mostly

unshift_path () {
  export PATH=$(perl -e '
    my $sep  = q{:};
    my $alt  = join q{|}, @ARGV;
    my $add  = qr/^(?:$alt)$/;
    # get the dirs in $PATH that are not being put on the front
    my @PATH = grep { !/$add/ } split /$sep/, $ENV{PATH};
    print join $sep, @ARGV, @PATH;
  ' "$@")
}

push_path () {
  export PATH=$(perl -e '
    my $sep  = q{:};
    my $alt  = join q{|}, @ARGV;
    my $add  = qr/^(?:$alt)$/;
    # get the dirs in $PATH that are not being put on the end
    my @PATH = grep { !/$add/ } split /$sep/, $ENV{PATH};
    print join $sep, @PATH, @ARGV;
  ' "$@")
}

uniq_path () {
  export PATH=$(perl -e '
    my $sep  = q{:};
    my %seen;
    my @PATH = grep { ! $seen{$_}++ } split /$sep/, $ENV{PATH};
    print join $sep, @PATH, @ARGV;
  ' "$@")
}

explode_path () {
  perl -e '
    my $PATH  = $ENV{PATH};
    my $sep   = q{:};
    my @parts = split /$sep/, $PATH;
    print "PATH:\n";
    print "  ", join("\n  ", @parts), "\n";
  '
}
