#!bash # for emacs highlighting

# detect my monitors

function rescan_displays () {
  local KEY=SPDisplaysDataType
  export MACOS_DISPLAYS=$(
    system_profiler $KEY | perl -ne '
      if (/^(\s+)Displays:/) { $prefix = $1 . q{  }; }
      if (length $prefix && /^$prefix(\S[^:]+):/) { push @D, $1; }
      END { print join q{:}, @D; }'
  )
}

function display_is () {
  local DTYPE="$1"
  [[ "$MACOS_DISPLAYS" == "" ]] && rescan_displays
  [[ "$MACOS_DISPLAYS" =~ "$DTYPE" ]]
}

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

function iTerm2_1337         () { printf "\033]1337;%s\a" "$@"; }
function steal_focus         () { iTerm2_1337 StealFocus; }
function clear_scroll_back   () { iTerm2_1337 ClearScrollback; }
function iTerm2_CurrentDir   () { iTerm2_1337 CurrentDir=$PWD; }
function iTerm2_SetProfile   () { iTerm2_1337 SetProfile="$@"; }
function iTerm2_BounceIcon   () { iTerm2_1337 RequestAttention=yes; }
function iTerm2_UnBounceIcon () { iTerm2_1337 RequestAttention=no; }
function iTerm2_notification () { printf "\033]9;%s\a" "$@"; }
function iTerm2_titlecolor   () { it2setcolor tab "$@"; }
function iTerm2_bgcolor      () { it2setcolor bg "$@"; export TERM_BGCOLOR="$@"; }
alias bgcolor=iTerm2_bgcolor

function iTerm2_cycle_bgcolor () {
  if [[ "$1" == "auto" ]]; then
    while true; do iTerm2_cycle_bgcolor; echo iTerm2_bgcolor $TERM_BGCOLOR; sleep 1; done
  fi
  if [[ "$TERM_BGCOLOR_LIST" == "" ]]; then
    if display_is SE39UY04; then
      bgcolor_high_list
    elif display_is DELL3007WFPHC; then
      bgcolor_low_list
    else # default for "Color LCD"
      bgcolor_low_list
    fi
  fi
  local DEFAULT_LIST DEFAULT_COLOR
  DEFAULT_LIST=000:333:400:600:800:020:030:220:330:440:002:004:008
  DEFAULT_LIST=$DEFAULT_LIST:022:044:202:404:606:313:424:535:326:548
  DEFAULT_LIST=$DEFAULT_LIST:407:515:516:518:627:620:630:640
  DEFAULT_COLOR=000

  export TERM_BGCOLOR_LIST=${TERM_BGCOLOR_LIST:-$DEFAULT_LIST}
  export TERM_BGCOLOR=${TERM_BGCOLOR:-$DEFAULT_COLOR}

  IFS=':' read -r -a array <<< "$TERM_BGCOLOR_LIST"
  for index in "${!array[@]}"; do
    if [[ "${array[index]}" == "$TERM_BGCOLOR" ]]; then
      i=$(( (index + 1) % ${#array[@]} ))
      iTerm2_bgcolor "${array[i]}"
      return
    fi
  done

  # we didn't find the current color on the list
  export TERM_BGCOLOR="${array[0]}"
  iTerm2_bgcolor $TERM_BGCOLOR
}
alias cycle_bgcolor=iTerm2_cycle_bgcolor

function bgcolor_high_list () {
  export TERM_BGCOLOR_LIST=000:555:666:600:800:040:050:004:005:006:007:008
  TERM_BGCOLOR_LIST=$TERM_BGCOLOR_LIST:044:055:066:505:606:707:808:708:809
  TERM_BGCOLOR_LIST=$TERM_BGCOLOR_LIST:718:627:620:970
}

function bgcolor_low_list () {
  export TERM_BGCOLOR_LIST=000:333:400:600:800:020:030:220:330:440:002:004:008
  TERM_BGCOLOR_LIST=$TERM_BGCOLOR_LIST:022:044:202:404:606:313:424:535:326:548
  TERM_BGCOLOR_LIST=$TERM_BGCOLOR_LIST:407:515:516:518:627:620:630:640
}
