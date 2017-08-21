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

function skype-mood-home () {
  set-skype-mood "🏠 🐾 @ Hackensack “Office”"
}

function skype-mood-aim () {
  set-skype-mood "⛪ @ 620 Union"
}

function skype-mood-pari () {
  set-skype-mood "👩🏻‍⚕️ @ 2-3PM medical appointment"
}
