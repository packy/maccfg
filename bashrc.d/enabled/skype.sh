#!bash # for emacs formatting

function set-skype-mood () {
  printf "Skype: "
  MOOD="$@"
  COMMAND="\"set profile mood_text $MOOD\""
  SCRIPT="\"AppleScript Mood Setter\""
  osascript <<SKYPE
tell application "Skype" to activate
tell application "Skype"
  delay 2
  tell application "System Events" to keystroke return
end tell
tell application "Skype" to send command $COMMAND script name $SCRIPT
SKYPE
}

function set-skype-status () {
  STATUS=$1
  case $STATUS in
    online|away|dnd|invisible|offline) ;;
    *) printf "Unknown user status. Known statuses are:"
       printf "\n + online\n + away\n + dnd (Do Not Disturb)"
       printf "\n + invisible\n + offline\n"
       return ;;
  esac
  printf "Skype: "
  COMMAND="\"set USERSTATUS $STATUS\""
  SCRIPT="\"AppleScript Status Setter\""
  osascript <<SKYPE
tell application "Skype" to send command $COMMAND script name $SCRIPT
SKYPE
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
  set-skype-status dnd
}

function skype-mood-lunch () {
  set-skype-mood "🍴 out to lunch"
  set-skype-status away
}
