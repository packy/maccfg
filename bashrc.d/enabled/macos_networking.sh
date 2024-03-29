#!bash # for emacs formatting

function wifi_is_off () {
  [[ "$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --getinfo)" = "AirPort: Off" ]]
}

function enable_wifi () {
  networksetup -setairportpower en0 on
}

function ssid () {
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --getinfo | perl -ne 'print $1 if /^\s+SSID:\s+(.+)$/;'
}

function ipaddresses () {
  ifconfig -a | perl -ne 'if (/(\d+\.\d+\.\d+\.\d+)/) { print "$1\n" }'
}

function non-local-ipaddresses () {
  ipaddresses | egrep -v '^(127.0.0.1|169.)'
}

function location () {
  networksetup -getcurrentlocation
}

function set-location () {
  LOC=${1:-'Automatic'};
  echo Setting location to $LOC
  sudo networksetup -switchtolocation "$LOC" >/dev/null

  while [[ -z "$(non-local-ipaddresses)" ]]; do
    sleep 1
  done
}

alias netutil='open /System/Library/CoreServices/Applications/Network\ Utility.app'
