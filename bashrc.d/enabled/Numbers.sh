#!bash

if [[ -d /Applications/Numbers.app ]]; then
  function numbers () {
    open -a Numbers "$@"
  }
fi
