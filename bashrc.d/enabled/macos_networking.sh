#!bash # for emacs formatting

function wifi_device () {
  networksetup -listallhardwareports | perl -nE '
    BEGIN { our $port=""; }
    if (/^Hardware Port:\s+([^\n]+)/) { $port = $1; }
    if (/^Device:\s+([^\n]+)/ && $port eq "Wi-Fi") { say $1; }
  '
}

function wifi_is_off () {
  # [[ "$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --getinfo)" = "AirPort: Off" ]]
  [[ "$(networksetup -getairportpower $(wifi_device) | perl -nE '/Wi-Fi Power \([^\)]+\): (\w+)/ && say $1;')" = "Off" ]]
}

function enable_wifi () {
  networksetup -setairportpower $(wifi_device) on
}

function ssid () {
    # /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --getinfo | perl -ne 'print $1 if /^\s+SSID:\s+(.+)$/;'
    # sudo wdutil info | perl -ne 'print $1 if /^\s+SSID\s+:\s+(.+)$/;'
    networksetup -getairportnetwork $(wifi_device) | perl -nE '/Current Wi-Fi Network: ([^\n]+)/ && say $1;'
}

function ipaddresses () {
  ifconfig -a | perl -ne 'if (/(\d+\.\d+\.\d+\.\d+)/) { print "$1\n" }'
}

function ipv6 () {
  ifconfig -a | grep inet6 | grep autoconf | awk '{ print $2 }'
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
