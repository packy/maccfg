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

function is_in_list () {
  if [[ "$#" -lt 2 ]] || [[ "$#" -gt 3 ]]; then
    >&2 echo "Usage: is_in_list \"\$LIST\" item [separator]"
    false
    return
  fi
  LIST="$1" ITEM="$2" SEP=${3:-':'}
  if [[ "$LIST" != "" ]]; then
    IFS="$SEP" read -r -a _list <<< "$LIST"
    for index in "${!_list[@]}"; do
      if [[ "${_list[index]}" == "$ITEM" ]]; then
        true
        return
      fi
    done
  fi
  false
}

# from https://github.com/gwaldo/dotfiles/blob/master/dot-zshrc
function yamllint () {
  for i in $(find . -name '*.yml' -o -name '*.yaml'); do echo $i; ruby -e "require 'yaml';YAML.load_file(\"$i\")"; done
}
