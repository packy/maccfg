#!/usr/bin/env bash
# for syntax highlightling in emacs, mostly

export ACK_COLOR_FILENAME=red
export ACK_PAGER='less -FRX'
re_source_file $HOME/git/ack2/completion.bash

# also, let's put grep configuration in here

export GREP_COLOR='30;43'
export GREP_OPTIONS='--color=auto'
