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

function add-app-to-dock () {
  PATH="$1"
  app_is_in_dock "$PATH" && return
  dock-defaults persistent-apps write -array-add "<dict>
  <key>tile-data</key>
  <dict>
    <key>file-data</key>
    <dict>
      <key>_CFURLString</key>
        <string>$PATH</string>
      <key>_CFURLStringType</key>
        <integer>0</integer>
    </dict>
  </dict>
</dict>"
}

function app_is_in_dock () {
  APPPATH=$(echo "$1" | perl -ne 'chomp; s/(\s)/sprintf "%%%02x", ord($1)/eg; print "file://$_"')
  defaults read com.apple.dock | grep _CFURLString | grep -q $APPPATH
}

function reload_dock () {
  local CHROME_APP="$HOME/Applications/Chrome Apps.localized"
  add-app-to-dock /Applications/iTerm.app/
  add-app-to-dock /Applications/Google\ Chrome.app/
  add-spacer-to-dock
  add-app-to-dock /Applications/Emacs.app/
  add-app-to-dock /Applications/Atom.app/
  add-spacer-to-dock
  # Hangouts
  add-app-to-dock "$CHROME_APP/Default knipolnnllmklapflnccelgolnpehhpl.app/"
}
