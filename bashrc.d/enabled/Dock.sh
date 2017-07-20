#!bash

function dock-defaults () {
  TYPE=$1; shift
  CMD=$1; shift
  case $CMD in
    add) CMD='-array-add' ;;
  esac
  defaults write com.apple.dock $TYPE $CMD "$@"
  killall Dock
}

function add-spacer-to-dock () {
  dock-defaults persistent-apps add '{"tile-type"="spacer-tile";}'
}

function add-recent-applications-to-dock () {
  dock-defaults persistent-others add \
    '{ "tile-data" = {"list-type" = 1; }; "tile-type" = "recents-tile";}'
}
