#!/usr/bin/env bash
# for syntax highlightling in emacs, mostly

if [[ ! -h $HOME/.homebrew_cellar ]]; then
    ln -sf $(brew --config | grep HOMEBREW_CELLAR | awk '{print $2}') \
       $HOME/.homebrew_cellar
fi

export HOMEBREW_CELLAR=$(readlink $HOME/.homebrew_cellar)
