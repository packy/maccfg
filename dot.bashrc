#!/usr/bin/env bash
# for syntax highlightling in emacs, mostly

# turn monitor mode OFF and
# suppress "[#] Done  /foo/bar" messages
set +o monitor

# preferred prompt: "user@host: path" in title, $ or # on command line
export PS1="\[\e]0;\u@\h: \w\007\]\\$ "

if [[ "$TERM" = "dumb" ]] ; then
  export TERM=xterm
fi

# I want to manipulate the path first
source $HOME/.bash_path_functions

# add dirs to the FRONT of the PATH
unshift_path /usr/local/bin
unshift_path /usr/local/opt/findutils/libexec/gnubin

# push dirs to the END of the PATH
push_path $HOME/bin

uniq_path # remove any duplicates in the PATH

# finally, load all the bash customizations
for DOTFILE in functions git ack aliases ls aws bmc; do
    if [[ -f $HOME/.bash_$DOTFILE ]]; then
        source $HOME/.bash_$DOTFILE
    fi
done

for MODULE in \
    ${HOME}/.iterm2_shell_integration.bash \
    $HOME/perl5/perlbrew/etc/bashrc ; do
    if [[ -f $MODULE ]]; then
        source $MODULE
    fi
done

gp # git prompt

ITERM2=
if [[ -f $ITERM2 ]]; then
    source $ITERM2
fi
export EDITOR=xemacs-wait
