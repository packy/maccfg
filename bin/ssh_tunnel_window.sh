#!/usr/bin/env bash
# get the fully qualified name of the currently running script
SELF="${BASH_SOURCE[0]}"
INVOKED_SELF="$SELF"
SELFDIR=$(cd $(dirname $SELF); pwd)
SELFNAME=$(basename "$SELF")
SELF="$SELFDIR/$SELFNAME"

export TUNNEL_REMOTE_HOST="$1"
export TUNNEL_REMOTE_PORT="$2"
export TUNNEL_LOCAL_PORT="${3:-$TUNNEL_REMOTE_PORT}"
export TUNNEL_USER="${4:-$USER}"

# make sure the proper environment variables have been set!
if [[ -z "$TUNNEL_REMOTE_HOST" ]] || \
   [[ -z "$TUNNEL_REMOTE_PORT" ]] || \
   [[ -z "$TUNNEL_LOCAL_PORT" ]]; then
    >&2 echo "Usage:"
    >&2 echo "  $INVOKED_SELF TUNNEL_REMOTE_HOST TUNNEL_REMOTE_PORT [TUNNEL_LOCAL_PORT]"
    exit 1
fi

if [[ ! -z "$(type xrun)" ]] && [[ $COLUMNS != 80 ]] && [[ $LINES != 5 ]]; then
  xrun --height 5 --width 80 --title "Tunnelling $TUNNEL_REMOTE_HOST:$TUNNEL_REMOTE_PORT to localhost:$TUNNEL_LOCAL_PORT" "$SELF $TUNNEL_REMOTE_HOST $TUNNEL_REMOTE_PORT $TUNNEL_LOCAL_PORT $TUNNEL_USER"
  exit
fi

ssh_control="/tmp/${TUNNEL_REMOTE_HOST}_${REMOTE_PORT}_ssh$$"
fifo_name="/tmp/${TUNNEL_REMOTE_HOST}_${REMOTE_PORT}_fifo$$"

function close {
    ssh -S ${ssh_control}.sock -O exit ${TUNNEL_USER}@$TUNNEL_REMOTE_HOST
    rm $fifo_name
}

# Close ssh tunnels
trap close SIGTERM SIGINT

function ask {
  while true; do
    if [ "$2" == "Y" ]; then
      prompt="\033[1;32mY\033[0m/n"
      default=Y
    elif [ "$2" == "N" ]; then
      prompt="y/\033[1;32mN\033[0m"
      default=N
    else
      prompt="y/n"
      default=
    fi

    printf "$1 [$prompt] "

    if [ "$auto" == "Y" ]; then
      echo
    else
      read yn
    fi

    if [ -z "$yn" ]; then
      yn=$default
    fi

    case $yn in
      [Yy]*) return 0 ;;
      [Nn]*) return 1 ;;
    esac
  done
}

while true; do
    printf "\e[2J\e[H" # clear screen
    # Create ssh tunnel database
    echo "Tunnelling $TUNNEL_REMOTE_HOST:$TUNNEL_REMOTE_PORT to localhost:$TUNNEL_LOCAL_PORT..."
    echo "Hit ^C to stop tunnel"
    /usr/bin/ssh -f -N -M -S "${ssh_control}.sock" ${TUNNEL_USER}@$TUNNEL_REMOTE_HOST -L $TUNNEL_LOCAL_PORT:127.0.0.1:$TUNNEL_REMOTE_PORT

    # wait for signal
    mkfifo $fifo_name
    read < $fifo_name
    close

    ask "Restart SSH tunnel?" Y || break
done

exit 0
