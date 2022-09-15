#!bash

if [[ -d /Applications/Microsoft\ Excel.app ]]; then
  function excel () {
    open -a Microsoft\ Excel "$@"
  }
fi

if [[ -d /Applications/Microsoft\ Word.app ]]; then
  function word () {
    open -a Microsoft\ Word "$@"
  }
fi

if [[ -d /Applications/Microsoft\ PowerPoint.app ]]; then
  function powerpoint () {
    open -a Microsoft\ PowerPoint "$@"
  }
fi

if [[ -d /Applications/Microsoft\ Teams.app ]]; then
  function teams () {
    open -a Microsoft\ Teams "$@"
  }
fi

if [[ -d /Applications/Microsoft\ Outlook.app ]]; then
  function outlook () {
    open -a Microsoft\ Outlook "$@"
  }
fi
