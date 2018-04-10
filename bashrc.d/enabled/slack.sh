# thanks to https://gist.github.com/samervin/621fcde93d28346ec5dbab4466b51d45
# for the example!

function slack_api_url () {
  METHOD=$1; shift
  echo "https://slack.com/api/$METHOD?token=$slacktoken"
}

function slack_status_get () {
  slacktoken=$(cat $HOME/.slack_token)
  apiurl=$(slack_api_url users.profile.set)
  curl -sS $apiurl
}

function slack_status_set () {
  EMOJI=$1; shift
  TEXT="$@"
  slacktoken=$(cat $HOME/.slack_token)
  apiurl=$(slack_api_url users.profile.set)
  curl -sS --data-urlencode "profile={\"status_text\":\"$TEXT\",\"status_emoji\":\"$EMOJI\"}" $apiurl &> /dev/null
}

function slack_presence_set () {
  TEXT=${1:-auto}
  if [[ "$TEXT" == "away" || "$TEXT" == "auto" ]]; then
    slacktoken=$(cat $HOME/.slack_token)
    apiurl=$(slack_api_url users.setPresence)
    echo "$apiurl\\&presence=$TEXT"
    curl -sS $apiurl\&presence=$TEXT
  else
    echo "Invalid presence '$TEXT'. Valid values are 'away' and 'auto'."
  fi
}

function slack-away () {
  slack_presence_set away > /dev/null
}

function slack-here () {
  slack_presence_set auto > /dev/null
}

function slack-status-pari () {
  echo "Setting slack status to 👩🏻‍⚕️ @ 10-11AM medical appointment"
  slack_status_set :female-health-worker:‍ @ 10-11AM medical appointment
  slack-away
}

function slack-status-home () {
  echo "Setting slack status to 🏠 (paws) @ Hackensack \“Office\”"
  slack_status_set :house: ':feet: @ Hackensack \"Office\"' > /dev/null
  slack-here
}

function slack-status-aim () {
  echo "Setting slack status to ⛪ @ 620 Union"
  slack_status_set :church: @ 620 Union > /dev/null
  slack-here
}

function slack-status-lunch () {
  echo "Setting slack status to 🍴 out to lunch"
  slack_status_set :fork-and-knife:‍ @ Lunch! > /dev/null
  slack-away
}

function pari () {
  slack-status-pari
  skype-mood-pari
}

function pari-at () {
  at $* <<PARI
SCRIPTS="macos_networking.sh slack.sh skype.sh"
for SCRIPT in $SCRIPTS; do
  source $HOME/.bashrc.d/enabled/$SCRIPT
done
pari
PARI
}

function lunch () {
  slack-status-lunch
  skype-mood-lunch
}

function msleep () {
  $HOME/.sleep
}
