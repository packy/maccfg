#!bash

function mysqlg () {
  mysql --defaults-group-suffix=$1
}

function mysqlctl () {
  local PLIST=$HOME/Library/LaunchAgents/homebrew.mxcl.mysql.plist
  case $1 in
    start)
      echo Starting MySQL...
      launchctl load -F $PLIST
      ;;
    stop)
      echo Stopping MySQL...
      launchctl unload -F $PLIST
      ;;
    restart)
      mysqlctl stop && mysqlctl start
      ;;
    *)
      >&2 echo "Unknown argument \"$1\"; try \"start\", \"stop\", or \"restart\""
      ;;
  esac
}
