#!/bin/bash
#
export EDITOR=xemacs
alias xe=xemacs

alias grep='grep --color=auto'

alias clean='rm -fv *~ .*~'

alias ll='ls -lGh'
alias ls='ls -G'
alias clear='printf "\e[2J"'

alias word='open -a Microsoft\ Word.app'

# aliases specific to my workplace

alias dcp='dcompile; push'
alias dcpna='dcompile; push --noagents'
alias gsa='gsquash --auto'

alias      b4='go b4'
alias     mgr='go packymgr'
alias    mgr2='go packymgr-release'
alias     agt='go rh5-si-336'
alias    agt2='go rh6-si-370'
alias     ibr='go 10.100.5.110'
alias markmgr='go rh6-ma-211'

alias bluehost='ssh dardanco@www.dardan.com'
alias sapdown='cd ~/SAP_Downloads/Download_Manager; java -classpath DLManager.jar dlmanager.Application; cd -'

alias eject="osascript -e 'tell application \"Finder\" to eject (every disk whose ejectable is true and local volume is true and free space is not equal to 0)'"

alias pacander='ssh -v adprod\\pacander@W-PACANDER-20.gridapp-dev.com'

alias rsync_pwd_to='rsync -avz .'

