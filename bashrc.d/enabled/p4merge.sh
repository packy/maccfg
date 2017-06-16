#!bash # for emacs formatting

# if we have p4merge installed, set up a function to call it
if [[ -x /Applications/p4merge.app/Contents/Resources/launchp4merge ]]; then
    p4diff ()
    {
      /Applications/p4merge.app/Contents/Resources/launchp4merge "$@" &
    }
fi

