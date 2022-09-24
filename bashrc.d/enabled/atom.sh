#!/usr/bin/env bash
# for syntax highlightling in emacs, mostly

# to get through proxy server
# https://github.com/atom/settings-view/issues/1063#issuecomment-419444171
export NODE_TLS_REJECT_UNAUTHORIZED=0

function atom {
  /Applications/Atom.app/Contents/Resources/app/atom.sh --proxy-server=http://genproxy:8080
}
alias a=atom
