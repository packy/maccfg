#!/bin/bash

rclean () {
    find . -name '*~' -o -name '.*~' | xargs rm -fv
}

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

mkdot () {
  echo "Making png files..."
  for DOT in $(ls *.dot); do
    PNG=$(perl -e 'my $png=shift; $png=~s/\.dot\z/.png/; print $png;' $DOT)
    echo "  $DOT => $PNG"
    dot -Tpng -o $PNG $DOT
  done
  echo "done."
}

7zarc () {
    for DIR in $*; do
        7z a -t7z -mx=9 -m0=lzma -mfb=64 -md=32m -ms=on $DIR.7z $DIR
        trash $DIR
        mkdir -p old/
        mv $DIR.7z old/
    done
}

pl2html () {
    PATHNAME=$1
    FILENAME=$(basename $PATHNAME)
    perltidy -html -hcc=red -nnn $PATHNAME -o /tmp/$FILENAME.html
    open /tmp/$FILENAME.html
    set +o monitor
    (sleep 5; rm -f /tmp/$FILENAME.html) &
}

ts () {
    export TS=$(date '+%Y-%m-%d %H:%M:%S')
}

get_front_window_bounds () {
    osascript -e "tell application \"$1\" to get bounds of the front window"
}
