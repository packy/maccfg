#!/bin/bash
#
export EDITOR=xemacs
alias xe=xemacs

alias grep='grep --color=auto'

alias clean='rm -fv *~ .*~'
alias rclean='find . -name '\''*~'\'' -exec rm -fv {} \;'

alias ll='ls -lG'
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
