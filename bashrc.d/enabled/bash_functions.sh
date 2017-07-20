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

pl2html () {
    PATHNAME=$1
    FILENAME=$(basename $PATHNAME)
    perltidy -html -hcc=red -nnn $PATHNAME -o /tmp/$FILENAME.html
    open /tmp/$FILENAME.html
    set +o monitor
    (sleep 5; rm -f /tmp/$FILENAME.html) &
}
