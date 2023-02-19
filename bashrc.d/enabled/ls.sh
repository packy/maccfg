#!/usr/bin/env bash
# for syntax highlightling in emacs, mostly

# /bin/ls options:
#
# -b Force printing of non-printable characters (as defined by
#    ctype(3) and current locale settings) in file names using
#    C escape codes whenever possible, and otherwise as \xxx
#    where xxx is the numeric value of the character in octal.
#
# -G Enable colorized output.  This option is equivalent to defining
#    CLICOLOR in the environment.
#
# -l List in long format.  If the output is to a terminal, a total
#    sum for all the file sizes is output on a line before the long
#    listing.
#
# -h When used with the -l option, use unit suffixes: Byte, Kilobyte,
#    Megabyte, Gigabyte, Terabyte and Petabyte in order to reduce the
#    number of digits to three or less using base 2 for sizes.
#
# -e Print the Access Control List (ACL) associated with the file, if
#    present, in long (-l) output.
#
# -O Include the file flags in a long (-l) output.
#
# -p Write a slash (`/') after each filename if that file is a directory.
#
# -H Symbolic links on the command line are followed.  This option is
#    assumed if none of the -F, -d, or -l options are specified.

#alias   ls='/bin/ls -bG'
#alias   ll='/bin/ls -bGlhOH'
#alias  lll='/bin/ls -bGlhOpH'
#alias llll='/bin/ls -bGlheOpH'
alias lllll='/bin/ls -bGlheOpH'

# https://the.exa.website/
# -l, --long
# Displays files in a table along with their metadata.

# --icons
# Displays Unicode icons by file names.

# -s, --sort=SORT_FIELD
# Configures which field to sort by.
#
# * name or filename sorts by name, case-insensitively.
# * Name or Filename sorts by name, case-sensitively.
# * cname or cfilename sorts by name, case-insensitively and canonically.
# * Cname or Cfilename sorts by name, case-sensitively and canonically.
# * .name or .filename sorts by name without a leading dot, case-insensitively.
# * .Name or .Filename sorts by name without a leading dot, case-sensitively.
# * size or filesize sorts by size, with smaller files listed first.
# * ext or extension sorts by file extension, case-insensitively.
# * Ext or Extension sorts by file extension, case-sensitively.
# * mod or modified sorts by file modified date, with older files listed first.
# * acc or accessed sorts by file accessed date.
# * cr or created sorts by file created date.
# * inode sorts by file inode.
# * type sorts by the type of file (directory, socket, link).
# * none disables sorting, and lists files in an arbitrary order.
#
# The modified field has the aliases date, time, and new, and newest. Also,
# because we usually think about dates relatively, its reverse has the
# aliases age, old, and oldest.
#
# Fields starting with a capital letter will sort uppercase before lowercase.
#
# Canonical sorting means that numbers will be treated as strings of digits
# instead of numbers. Normally, 9 comes before 10, but sorting by Cname will
# sort 10 before 9 because it sees the 1 digit first.

# --group-directories-first
# Lists directories before other files when sorting.

# -g, --group
# Lists each file’s group.

# -h, --header
# Adds a header row to each column in the table.

# -@, --extended
# Lists each file’s extended attributes and sizes.

# --git
# Lists each file’s Git status, if tracked.

# --color-scale, --colour-scale
# Highlights levels of file size distinctly.

alias    ls='exa --group-directories-first'
alias    ll='exa --long --header --group --icons --git --group-directories-first --color-scale'
alias   lll='exa --long --header --group --icons --git --group-directories-first --color-scale --classify'
alias  llll='exa --long --header --group --icons --git --group-directories-first --color-scale --classify --extendeda'

#alias llrt='/bin/ls -bGlhOHrt'
alias llrt='exa -lhg --icons --sort=mod'

# LSCOLORS
# The value of this variable describes what color to use for which
# attribute when colors are enabled with CLICOLOR.  This string is a
# concatenation of pairs of the format fb, where f is the foreground
# color and b is the background color.
#
# The color designators are as follows:
#
#       a     black
#       b     red
#       c     green
#       d     brown
#       e     blue
#       f     magenta
#       g     cyan
#       h     light grey
#       A     bold black, usually shows up as dark grey
#       B     bold red
#       C     bold green
#       D     bold brown, usually shows up as yellow
#       E     bold blue
#       F     bold magenta
#       G     bold cyan
#       H     bold light grey; looks like bright white
#       x     default foreground or background
#
# Note that the above are standard ANSI colors.  The actual display
# may differ depending on the color capabilities of the terminal in
# use.
#
# The order of the attributes are as follows:
#       1.   directory
#       2.   symbolic link
#       3.   socket
#       4.   pipe
#       5.   executable
#       6.   block special
#       7.   character special
#       8.   executable with setuid bit set
#       9.   executable with setgid bit set
#       10.  directory writable to others, with sticky bit
#       11.  directory writable to others, without sticky bit
#
# The default is "exfxcxdxbxegedabagacad", i.e. blue foreground and
# default background for regular directories, black foreground and red
# background for setuid executables, etc.

export  CLICOLOR=1
export  LSCOLORS=ExFxfxdxCxehbhBxGxDcDx
#export LSCOLORS=ExfxFxdxCxehbhabagacad
#export LSCOLORS=ExfxFxdxCxGgDdabagacad
#export LSCOLORS=Exfxcxdxbxegedabagacad

function demo_ls_colors () {
    #
    # define examples
    #
    local DIR=/tmp/cdemo
    local FILE01=1-directory
    local FILE02=2-symbolic_link
    local FILE03=3-socket
    local FILE04=4-pipe
    local FILE05=5-executable
    local FILE06=/dev/disk0
    local FILE07=/dev/console
    local FILE08=8-exe_setuid
    local FILE09=9-exe_setgid
    local FILE10=A-dir_writeothers_stickybit
    local FILE11=B-dir_writeothers_NOsticky

    #
    # make examples
    #
    mkdir -p $DIR; cd $DIR
    mkdir -p $FILE01
    ln -s /tmp $FILE02
    python -c "import socket as s; sock = s.socket(s.AF_UNIX); sock.bind('$FILE03')"
    mkfifo $FILE04
    touch    $FILE05 ;                          chmod u+x    $FILE05
    touch    $FILE08 ;                          chmod u+sx   $FILE08
    touch    $FILE09 ; chgrp everyone $FILE09 ; chmod g+sx   $FILE09
    mkdir -p $FILE10 ;                          chmod o+w,+t $FILE10
    mkdir -p $FILE11 ;                          chmod o+w    $FILE11

    echo
    echo Generate new spec with http://geoff.greer.fm/lscolors/
    echo
    local  FORMAT01=" 1 - directory (%s):                                "
    local  FORMAT02=" 2 - symbolic link (%s): . . . . . . . . . . . . .  "
    local  FORMAT03=" 3 - socket (%s):                                   "
    local  FORMAT04=" 4 - pipe (%s):  . . . . . . . . . . . . . . . . .  "
    local  FORMAT05=" 5 - executable (%s):                               "
    local  FORMAT06=" 6 - block special (%s): . . . . . . . . . . . . .  "
    local  FORMAT07=" 7 - character special (%s):                        "
    local  FORMAT08=" 8 - executable with setuid bit set (%s):  . . . .  "
    local  FORMAT09=" 9 - executable with setgid bit set (%s):           "     
    local  FORMAT10=" A - dir writeable to others, with sticky bit (%s): "
    local  FORMAT11=" B - dir writeable to others, NO sticky bit (%s):   "

    # display colors!
    ls -Glnhd * $FILE06 $FILE07

    echo
    echo LSCOLORS=$LSCOLORS yields:
    for i in 1 2 3 4 5 6 7 8 9 10 11; do
        FMT=$(printf "\$FORMAT%02d" $i); eval FORMAT="$FMT"
        FIL=$(printf "\$FILE%02d" $i);   eval FILE="$FIL"
        CODE=$(perl -e 'print substr($ENV{LSCOLORS}, ($ARGV[0]-1) * 2, 2)' $i)
        printf "$FORMAT" $CODE; ls -Gd $FILE
    done
    echo
    cd - >/dev/null
    rm -rf $DIR
}
