#!/usr/bin/env bash

# I keep forgetting how to do these little things whenever
# I'm writing bash scripts, so I'm putting them in an easily
# found place for future reference

# get the fully qualified name of the currently running script
SELF="${BASH_SOURCE[0]}"
SELFDIR=$(cd $(dirname $SELF); pwd)
SELFNAME=$(basename "$SELF")
SELF="$SELFDIR/$SELFNAME"

# if the script isn't being run by the user $RUNUSER,
# re-run it as the user $RUNUSER
if [[ "$USER" != "$RUNUSER" ]]; then
  # change the propmt so it's clear whose password is being requested
  sudo --prompt="%u's Password: " -u $RUNUSER $SELF
  exit
fi

# print to stderr
>&2 echo this output goes to stderr

# define a bash array
declare -A SERVER
SERVER["prod"]="srv-01"
SERVER["stage"]="srv-02"
SERVER["test"]="srv-03"

# reference the array
HOST=${SERVER[$ENVIRONMENT]}

# have ssh just accept host keys without prompting
ssh -oStrictHostKeyChecking=no -t $HOST $CMD

# pass all args from this script to a new one
script "$@"
