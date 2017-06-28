#!bash # for emacs highlighting

APP=/Applications/Emacs.app/Contents/MacOS
export EMACSCLIENT=$APP/bin/emacsclient

alias emacs="$APP/Emacs -nw"

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

function xemacs-start-server () {
    local EMACS_SERVER_SOCKET=$TMPDIR/emacs$EUID/server

    if [[ ! -e $EMACS_SERVER_SOCKET ]]; then
        # launch the editor
        # /Applications/Emacs.app/Contents/MacOS/Emacs $* &
        open -a emacs # let macOS take care of starting emacs if it isn't open

        # wait for the server to start up
        while [[ ! -e $EMACS_SERVER_SOCKET ]]; do sleep 1; done
    fi
}

function xemacs () {
    xemacs-start-server
    osascript -e 'tell application "Emacs"' -e 'activate' -e 'end tell'

    # open the files in different windows if possible
    local FUNC=find-file-other-window

    if [[ $1 == "-r" ]]; then
        shift
        FUNC=find-file-read-only-other-window
    fi

    # open the files in different windows if possible
    for FILE in "$@"; do
        $EMACSCLIENT --quiet --no-wait --eval "($FUNC \"$FILE\")" >/dev/null
    done
}

function xemacs-wait () {
    xemacs-start-server
    osascript -e 'tell application "Emacs"' -e 'activate' -e 'end tell'
    $EMACSCLIENT "$@"
}
