#!bash # for emacs highlighting

# http://hackipedia.org/Protocols/Terminal,%20DEC%20VT100/html/VT100%20Escape%20Codes.html

function clear () {
    is_interactive && printf "\e[2J"
}

function cleartop () {
    is_interactive && printf "\e[2J\e[H"
}

# cursor manipulation

function save_cursor () {
    is_interactive && printf "\e[s" # \e[s saves cursor position
}

function restore_cursor () {
    is_interactive && printf "\e[u" # \e[u restores cursor position
}

function clear_line_cursor_right () {
    is_interactive && printf "\e[K" # \e[K clears screen from cursor right
}

function clear_screen_cursor_down () {
    is_interactive && printf "\e[J" # \e[J clears screen from cursor right
}

function scroll_if_at_bottom () {
    is_interactive && printf "\n\e[1A" # newline, cursor up 1 line
}

function restore_cursor_clear_line () {
    restore_cursor && clear_line_cursor_right
}

function restore_cursor_clear_down () {
    restore_cursor && clear_screen_cursor_down
}

# window manipulation

function xtitle () {
    is_interactive && printf "\e]0;%s\007" "$1";
}

function xsize () {
    WIDTH=${1:-"80"};
    HEIGHT=${2:-"50"};
    is_interactive && printf "\e[8;%d;%dt" $HEIGHT $WIDTH;
}

# iTerm2 manipulation

function iTerm2_1337 ()       { printf "\033]1337;%s\a" "$@"; }
function steal_focus ()       { iTerm2_1337 StealFocus; }
function clear_scroll_back () { iTerm2_1337 ClearScrollback; }
function notification ()      { printf "\033]9;%s\a" "$@"; }
function iTerm2_CurrentDir () { iTerm2_1337 CurrentDir=$PWD; }
function iTerm2_SetProfile () { iTerm2_1337 SetProfile="$@"; }
function iTerm2_BounceIcon () { iTerm2_1337 RequestAttention=yes; }
function iTerm2_UnBounceIcon () { iTerm2_1337 RequestAttention=no; }

function set_term_profile () {
    PROFILE=${1:-"Default"};
    is_interactive && printf "\e]50;SetProfile=%s\a" "$PROFILE";
}

function set_term_bgcolor () {
    perl -e '
my $color = shift @ARGV;
my($r,$g,$b) = $color =~ /(..)(..)(..)/;
($r,$g,$b) = ( hex($r) * 65535/255, hex($g) * 65535/255, hex($b) * 65535/255 );
print qq(tell application "iTerm2"
  tell current session of current window
    set background color to {$r,$g,$b} # color $color
  end tell
end tell
)
' "$@" | osascript
}

function set_term_titlecolor () {
  perl -e '
my $color = shift @ARGV;
my($r,$g,$b) = $color =~ /^([0-f]{2})([0-f]{2})([0-f]{2})$/;
unless (defined $r && defined $g && defined $b) {
  if ( ($r,$g,$b) = $color =~ /^([0-f]{1})([0-f]{1})([0-f]{1})$/ ) {
    ($r,$g,$b) = ( $r x 2, $g x 2, $b x 2 );
  }
}
if ( defined $r && defined $g && defined $b ) {
  ($r,$g,$b) = ( hex($r), hex($g), hex($b) );
  print "\033]6;1;bg;red;brightness;$r\a"
      . "\033]6;1;bg;green;brightness;$g\a"
      . "\033]6;1;bg;blue;brightness;$b\a"
}
elsif ( $color =~ /^d?e?f?a?u?l?t?/i ) {
  print "\033]6;1;bg;*;default\a";
}
else {
  print STDERR "Unknown color specification: '$color'\n";
  exit 1;
}
' "$@"
}

function cycle_term_bgcolor () {
  local DEFAULT_LIST="000000:770000:000044:004400:005566:660066:660055:555500"
  local DEFAULT_COLOR="000000"
  export TERM_BGCOLOR_LIST=${TERM_BGCOLOR_LIST:-$DEFAULT_LIST}
  export TERM_BGCOLOR=${TERM_BGCOLOR:-$DEFAULT_COLOR}
  IFS=':' read -r -a array <<< "$TERM_BGCOLOR_LIST"
  for index in "${!array[@]}"; do
    if [[ "${array[index]}" == "$TERM_BGCOLOR" ]]; then
      i=$(( (index + 1) % ${#array[@]} ))
      export TERM_BGCOLOR="${array[i]}"
      set_term_color_palette --background $TERM_BGCOLOR
      return
    fi
  done
  # we didn't find the current color on the list
  export TERM_BGCOLOR="${array[0]}"
  set_term_color_palette --background $TERM_BGCOLOR
}
