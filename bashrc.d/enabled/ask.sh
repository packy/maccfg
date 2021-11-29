#!/usr/bin/env bash

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
