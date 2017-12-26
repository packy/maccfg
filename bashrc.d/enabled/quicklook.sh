#!bash # for emacs formatting

# remote quick look!
function rql () {
  for FILE in $*; do
    BASENAME=$(basename $FILE)
    scp $FILE ~/Downloads/
    qlmanage -p ~/Downloads/$BASENAME &>/dev/null
    rm -f ~/Downloads/$BASENAME
  done
}
