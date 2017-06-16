#!bash # for emacs formatting

function ssid () {
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --getinfo | perl -ne 'print $1 if /^\s+SSID:\s+(.+)$/;'
}
