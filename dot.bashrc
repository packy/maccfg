#!/usr/bin/env bash
# for syntax highlightling in emacs, mostly

function save_cursor () {
    printf "\e[s" # \e[s saves cursor position
}

function restore_cursor_clear_down () {
    printf "\e[u\e[J" # restore cursor, clear screen from cursor down
}

function source_file () {
    FILE=$1
    PRINTERR=$2
    if [[ -f $FILE ]]; then
        save_cursor
        printf "Sourcing %s ...\n" $FILE
        source $FILE
        restore_cursor_clear_down
    elif [[ "$PRINTERR" != "" ]]; then
        echo ERROR: Unable to find $FILE >> /dev/stderr
    fi
}

# turn monitor mode OFF and
# suppress "[#] Done  /foo/bar" messages
set +o monitor

# preferred prompt: "user@host: path" in title, $ or # on command line
export PS1="\[\e]0;\u@\h: \w\007\]\\$ "

if [[ "$TERM" = "dumb" ]] ; then
  export TERM=xterm
fi

# I want to manipulate the path first
source_file $HOME/.bash_path_functions "Error if not found"

# add dirs to the FRONT of the PATH
unshift_path /usr/local/bin
unshift_path /usr/local/opt/findutils/libexec/gnubin

# push dirs to the END of the PATH
push_path $HOME/bin

uniq_path # remove any duplicates in the PATH

# finally, load all the bash customizations
for DOTFILE in functions ack aliases ls perforce aws bmc git; do
    source_file $HOME/.bash_$DOTFILE
done

for MODULE in \
    $HOME/.iterm2_shell_integration.bash \
    $HOME/perl5/perlbrew/etc/bashrc ; do
    source_file $MODULE
done

gp # git prompt

export EDITOR=xemacs-wait
