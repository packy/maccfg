#!bash - for syntax highlightling in emacs, mostly
#
# =item ACKRC
#
# Specifies the location of the user's F<.ackrc> file.  If this file doesn't
# exist, F<ack> looks in the default location.
#
# =item ACK_OPTIONS
#
# This variable specifies default options to be placed in front of
# any explicit options on the command line.
#
# =item ACK_COLOR_FILENAME
#
# Specifies the color of the filename when it's printed in B<--group>
# mode.  By default, it's "bold green".
#
# The recognized attributes are clear, reset, dark, bold, underline,
# underscore, blink, reverse, concealed black, red, green, yellow,
# blue, magenta, on_black, on_red, on_green, on_yellow, on_blue,
# on_magenta, on_cyan, and on_white.  Case is not significant.
# Underline and underscore are equivalent, as are clear and reset.
# The color alone sets the foreground color, and on_color sets the
# background color.
#
# This option can also be set with B<--color-filename>.

export ACK_COLOR_FILENAME="bold red"

# =item ACK_COLOR_MATCH
#
# Specifies the color of the matching text when printed in B<--color>
# mode.  By default, it's "black on_yellow".
#
# This option can also be set with B<--color-match>.
#
# See B<ACK_COLOR_FILENAME> for the color specifications.
#
# =item ACK_COLOR_LINENO
#
# Specifies the color of the line number when printed in B<--color>
# mode.  By default, it's "bold yellow".
#
# This option can also be set with B<--color-lineno>.

export ACK_COLOR_LINENO="bold green"

# See B<ACK_COLOR_FILENAME> for the color specifications.
#
# =item ACK_PAGER
#
# Specifies a pager program, such as C<more>, C<less> or C<most>, to which
# ack will send its output.
#
# Using C<ACK_PAGER> does not suppress grouping and coloring like
# piping output on the command-line does, except that on Windows
# ack will assume that C<ACK_PAGER> does not support color.
#
# C<ACK_PAGER_COLOR> overrides C<ACK_PAGER> if both are specified.

export ACK_PAGER='less -FRX'

# =item ACK_PAGER_COLOR
#
# Specifies a pager program that understands ANSI color sequences.
# Using C<ACK_PAGER_COLOR> does not suppress grouping and coloring
# like piping output on the command-line does.
#
# If you are not on Windows, you never need to use C<ACK_PAGER_COLOR>.
#
# =back
#
# =head1 AVAILABLE COLORS
#
# F<ack> uses the colors available in Perl's L<Term::ANSIColor> module, which
# provides the following listed values. Note that case does not matter when using
# these values.
#
# =head2 Foreground colors
#
#     black  red  green  yellow  blue  magenta  cyan  white
#
#     bright_black  bright_red      bright_green  bright_yellow
#     bright_blue   bright_magenta  bright_cyan   bright_white
#
# =head2 Background colors
#
#     on_black  on_red      on_green  on_yellow
#     on_blue   on_magenta  on_cyan   on_white
#
#     on_bright_black  on_bright_red      on_bright_green  on_bright_yellow
#     on_bright_blue   on_bright_magenta  on_bright_cyan   on_bright_white

re_source_file $HOME/git/ack2/completion.bash

# also, let's put grep configuration in here

export GREP_COLOR='30;43'
export GREP_OPTIONS='--color=auto'
