#!/bin/bash

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

# if we have p4merge installed, set up a function to call it
if [[ -x /Applications/p4merge.app/Contents/Resources/launchp4merge ]]; then
    p4diff ()
    {
      /Applications/p4merge.app/Contents/Resources/launchp4merge "$@" &
    }
fi


