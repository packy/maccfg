#!bash

function dock-defaults () {
  TYPE=$1; shift
  CMD=$1; shift

  defaults $CMD com.apple.dock $TYPE "$@"
  killall Dock
}

function add-spacer-to-dock () {
  dock-defaults persistent-apps write -array-add '{"tile-type"="spacer-tile";}'
}

function add-recent-applications-to-dock () {
  dock-defaults persistent-others write -array-add \
    '{ "tile-data" = {"list-type" = 1; }; "tile-type" = "recents-tile";}'
}

function dock-autohide () {
  dock-defaults autohide write -float 1
}

function dock-noautohide () {
  dock-defaults autohide delete
}

function dock-autohide-nodelay () {
  dock-defaults autohide-delay write -float 0
}

function dock-autohide-delay () {
  dock-defaults autohide-delay delete
}
