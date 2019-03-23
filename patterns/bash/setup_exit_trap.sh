#!/usr/bin/env bash

declare -a EXIT_COMMANDS

# set up a function to clean up when we exit
function exit_trap () {
  for CMD in "${EXIT_COMMANDS[@]}"; do
    eval "$CMD"
  done
}
trap exit_trap EXIT

function add_to_exit_trap () {
  EXIT_COMMANDS+=("$*")
}
