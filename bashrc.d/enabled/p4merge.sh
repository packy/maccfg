#!bash # for emacs formatting

# if we have p4merge installed, set up a function to call it
P4MERGE=/Applications/p4merge.app/Contents/Resources/launchp4merge
[[ -x $P4MERGE ]] || return

export P4MERGE
p4diff () {
    $P4MERGE "$@" &
}
