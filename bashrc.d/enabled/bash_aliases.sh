#!/bin/bash
#


alias bluehost='ssh dardanco@www.dardan.com'

alias eject="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true and local volume is true and free space is not equal to 0)'"

alias rsync_pwd_to='rsync -avz .'

alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# aliases to AppleScripts to open Google Tools

export MY_APPLESCRIPTS="$GITDIR/maccfg/AppleScript"

alias inbox='osascript "$MY_APPLESCRIPTS/Open Google Inbox.applescript"'
alias music='osascript "$MY_APPLESCRIPTS/Open Google Play Music.applescript"'
alias play='osascript "$MY_APPLESCRIPTS/Open Google Play Music.applescript"'
