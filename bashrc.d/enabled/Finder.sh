#!bash

function finder-hide () {
  chflags hidden "$@"
}

function finder-nohide () {
  chflags nohidden "$@"
}

function finder-screencapture-path () {
  defaults write com.apple.screencapture "$@"
  killall SystemUIServer
}

function finder-screencapture-dropshadow () {
  if [[ "${1^^}" == "ON" ]]; then
    defaults write com.apple.screencapture disable-shadow -bool false
    killall SystemUIServer
  elif [[ "${1^^}" == "OFF" ]]; then
    defaults write com.apple.screencapture disable-shadow -bool true
    killall SystemUIServer
  else
    >&2 echo "Usage: finder-screencapture-dropshadow <ON|OFF>"
  fi
}
