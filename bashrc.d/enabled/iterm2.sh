#!bash # for emacs highlighting

# first, determine how we base64 encode
if type b64encode >/dev/null 2>&1; then B64ENC="b64encode -r /dev/null"
else if type base64 >/dev/null 2>&1; then B64ENC="base64"
fi; fi

function iTerm2_1337              () { printf "\033]1337;%s\a" "$@"; }
function iTerm2_steal_focus       () { iTerm2_1337 StealFocus; }
function iTerm2_clear_scroll_back () { iTerm2_1337 ClearScrollback; }
function iTerm2_CurrentDir        () { iTerm2_1337 CurrentDir=$PWD; }
function iTerm2_SetProfile        () { iTerm2_1337 SetProfile="$@"; }
function iTerm2_BounceIcon        () { iTerm2_1337 RequestAttention=yes; }
function iTerm2_UnBounceIcon      () { iTerm2_1337 RequestAttention=no; }
function iTerm2_notification      () { printf "\033]9;%s\a" "$@"; }
function iTerm2_SetColors         () { iTerm2_1337 SetColors="$1=$2"; }
function iTerm2_titlecolor        () { iTerm2_SetColors tab "$@"; }
function iTerm2_bgcolor           () { iTerm2_SetColors bg "$@"; export TERM_BGCOLOR="$@"; }
function iTerm2_SetBadge          () { iTerm2_1337 SetBadgeFormat=$(echo "$@" | $B64ENC); }
alias bgcolor=iTerm2_bgcolor
alias set_term_titlecolor=iTerm2_titlecolor

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
  DEFAULT_LIST=000:333:400:600:020:030:220:330:440:002:004:008
  DEFAULT_LIST=$DEFAULT_LIST:022:044:202:404:606:313:424:535:326:548
  DEFAULT_LIST=$DEFAULT_LIST:407:515:516:518:627:620:630:640
  DEFAULT_COLOR=000

  export TERM_BGCOLOR_LIST=${TERM_BGCOLOR_LIST:-$DEFAULT_LIST}
  export TERM_BGCOLOR=${TERM_BGCOLOR:-$DEFAULT_COLOR}
  export TERM_PREVIOUS_BGCOLOR=$TERM_BGCOLOR

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
function last_bgcolor () { iTerm2_bgcolor $TERM_PREVIOUS_BGCOLOR; }

function bgcolor_high_list () {
  export TERM_BGCOLOR_LIST=000:555:666:600:040:050:004:005:006:007:008
  TERM_BGCOLOR_LIST=$TERM_BGCOLOR_LIST:044:055:066:505:606:707:808:708:809
  TERM_BGCOLOR_LIST=$TERM_BGCOLOR_LIST:718:627:620:970
}

function bgcolor_low_list () {
  export TERM_BGCOLOR_LIST=000:333:400:600:020:030:220:330:002:004:008
  TERM_BGCOLOR_LIST=$TERM_BGCOLOR_LIST:022:044:202:404:606:313:424:535:326:548
  TERM_BGCOLOR_LIST=$TERM_BGCOLOR_LIST:407:515:516:518:627:620:630:640
}

function reset () {
  iTerm2_titlecolor default
  iTerm2_bgcolor 000
  /usr/bin/reset
}
