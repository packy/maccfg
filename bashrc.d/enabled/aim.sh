#!bash # for emacs formatting

re_source_file $HOME/.bash_aim # work files

# function to indent the contents of the paste buffer N spaces
pbindent () {
  pbpaste | INDENT=$1 perl -pe 's/^/" "x$ENV{INDENT}/e' | pbcopy
}
