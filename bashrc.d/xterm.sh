#!bash # for emacs highlighting

# http://hackipedia.org/Protocols/Terminal,%20DEC%20VT100/html/VT100%20Escape%20Codes.html

function clear () {
    is_interactive && printf "\e[2J"
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
