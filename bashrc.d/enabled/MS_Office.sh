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
