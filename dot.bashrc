# turn monitor mode OFF and
# suppress "[#] Done  /foo/bar" messages
set +o monitor

export PS1="\[\e]0;\u@\h: \w\007\]\\$ "

if [[ "$TERM" = "dumb" ]] ; then
  export TERM=xterm
fi

. $HOME/.bash_functions
. $HOME/.bash_git
. $HOME/.bash_ack
. $HOME/.bash_aliases
. $HOME/.bash_ls
. $HOME/git/z/z.sh
gp # git prompt

unshift_path /usr/local/bin
push_path $HOME/bin
uniq_path

export EDITOR=xemacs-wait
