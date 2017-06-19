#!/bin/bash
#
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"

if is_local; then
    export EDITOR=xemacs
    alias xe=xemacs
else
    export EDITOR=emacs
    export GIT_EDITOR=emacs
    alias xe=emacs
fi

alias clean='rm -fv *~ .*~'
alias rclean="find . -name '*~' -o -name '.*~' | xargs rm -fv"

alias clear='printf "\e[2J"'

alias word='open -a Microsoft\ Word.app'

alias bluehost='ssh dardanco@www.dardan.com'

alias eject="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true and local volume is true and free space is not equal to 0)'"

alias rsync_pwd_to='rsync -avz .'

alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# aliases to AppleScripts to open Google Tools

export MY_APPLESCRIPTS="$GITDIR/maccfg/AppleScript"

alias inbox='osascript "$MY_APPLESCRIPTS/Open Google Inbox.applescript"'
alias music='osascript "$MY_APPLESCRIPTS/Open Google Play Music.applescript"'
alias play='osascript "$MY_APPLESCRIPTS/Open Google Play Music.applescript"'
