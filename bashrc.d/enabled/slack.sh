# thanks to https://gist.github.com/samervin/621fcde93d28346ec5dbab4466b51d45
# for the example!

function slack_status_get () {
  slacktoken=$(cat $HOME/.slack_token)
  apiurl="https://slack.com/api/users.profile.get?token=$slacktoken"
  curl $apiurl
}

function slack_status_set () {
  EMOJI=$1; shift
  TEXT="$@"
  slacktoken=$(cat $HOME/.slack_token)
  apiurl="https://slack.com/api/users.profile.set?token=$slacktoken"
  curl --silent --data-urlencode "profile={\"status_text\":\"$TEXT\",\"status_emoji\":\"$EMOJI\"}" $apiurl
}

function slack-status-pari () {
  echo "Setting slack status to 👩🏻‍⚕️ @ 2-3PM medical appointment"
  slack_status_set :female-health-worker:‍ @ 2-3PM medical appointment > /dev/null
}

function slack-status-home () {
  echo "Setting slack status to 🏠 (paws) @ Hackensack \“Office\”"
  slack_status_set :house: ':feet: @ Hackensack \"Office\"' > /dev/null
}

function slack-status-aim () {
  echo "Setting slack status to ⛪ @ 620 Union"
  slack_status_set :church: @ 620 Union > /dev/null
}

function pari () {
  slack-status-pari
  skype-mood-pari
}
