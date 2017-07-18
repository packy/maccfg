#!bash

function finder-hide () {
  chflags hidden "$@"
}

function finder-nohide () {
  chflags nohidden "$@"
}

function finder-screencapture-path () {
  defaults write com.apple.screencapture "$@"
}
