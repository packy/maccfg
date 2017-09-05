#!bash # for emacs formatting

function set-skype-mood () {
  printf "Skype: "
  MOOD="$@"
  APP="\"Skype\""
  COMMAND="\"set profile mood_text $MOOD\""
  SCRIPT="\"AppleScript Mood Setter\""
  osascript \
    -e "tell application $APP to send command $COMMAND script name $SCRIPT"
}

function set-skype-status () {
  printf "Skype: "
  STATUS=$1
  APP="\"Skype\""
  COMMAND="\"set USERSTATUS $STATUS\""
  SCRIPT="\"AppleScript Status Setter\""
  osascript \
    -e "tell application $APP to send command $COMMAND script name $SCRIPT"
}

function skype-mood-home () {
  set-skype-mood "🏠 🐾 @ Hackensack “Office”"
  set-skype-status online
}

function skype-mood-aim () {
  set-skype-mood "⛪ @ 620 Union"
  set-skype-status online
}

function skype-mood-pari () {
  set-skype-mood "👩🏻‍⚕️ @ 2-3PM medical appointment"
  set-skype-status away
}
