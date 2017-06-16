#!bash # for emacs highlighting

function scroll_if_at_bottom () {
    is_interactive && printf "\n\e[1A" # newline, cursor up 1 line
}
scroll_if_at_bottom

function save_cursor () {
    is_interactive && printf "\e[s" # \e[s saves cursor position
}

function restore_cursor_clear_down () {
    is_interactive && printf "\e[u\e[J" # restore cursor, clear screen from cursor down
}

function xtitle () {
    is_interactive && printf "\e]0;%s\007" "$1";
}

function xsize () {
    WIDTH=${1:-"80"};
    HEIGHT=${2:-"50"};
    is_interactive && printf "\e[8;%d;%dt" $HEIGHT $WIDTH;
}

xprofile () {
    PROFILE=${1:-"Default"};
    is_interactive && printf "\e]50;SetProfile=%s\a" "$PROFILE";
}
