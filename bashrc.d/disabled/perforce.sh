#!/usr/local/bin/bash

export P4PORT=${P4PORT:-rnd-scm.bmc.com:4742}
export P4USER=${P4USER:-pacander}
export P4CLIENT=${P4CLIENT:-packy_pacbook}
export P4TICKETS=${P4TICKETS:-$HOME/.p4tickets}

P4N='if ! p4 login -s; then p4 login; fi; if git config --get ccollab.ensure-content-reviewed >/dev/null; then echo Code in $(basename `pwd`) must go through Code Collaborator; else git p4 submit; fi'
alias p4noedit=$P4N
alias p4n=$P4N
unset P4N

p4vars () {
    set | grep ^P4
}

p4l () {
    PASSWORD=$(perl -e '
use Net::Netrc;
exit unless $ENV{P4PORT};
my ($host) = split /:/, $ENV{P4PORT};
my $entry = Net::Netrc->lookup($host);
print $entry->password;
')
    if [[ "$PASSWORD" != "" ]]; then
        echo "$PASSWORD" | p4 login >/dev/null
    else
        p4 login
    fi
    ~/BitBar/PerforceTicketStatus.1m.sh
}

p4_revertall () {
    p4 opened | perl -ne 's/\#.*$//; print;' | xargs p4 revert
}


#
# git customizations
#

git config --global git-p4.autostash True

function p4 () {
    if [[ $EUID -eq 0 ]]; then
        echo "Don't run perforce as root!" 1>&2
        bash -c "exit 1"; # so the status is 1
    else
        /usr/local/bin/p4 "$@"
    fi
}

function is_git-p4_repo () {
    git rev-parse --symbolic --remotes 2>/dev/null | grep ^p4/
}

syncall () {
   CURDIR=`pwd`
   DIRS=$(find "$GITDIR" -maxdepth 1 -type d | sed -e "s:$GITDIR/::" | grep -v "$GITDIR")
   p4 sync
   for DIR in $DIRS; do
       cd "$GITDIR/$DIR"
       if is_git_p4_dir; then
           printf "\n\n========================= $DIR =========================\n\n"
           CHANGES=$(git status --short --untracked-files=no)
           OLDBRANCH=$(parse_git_branch)
           if [[ "$CHANGES" != "" ]]; then
               echo Stashing uncommitted changes
               git stash
           fi
           if [[ "$OLDBRANCH" != "master" ]]; then
               git co master
           fi
           git up
           git gc
           if [[ "$OLDBRANCH" != "master" ]]; then
               git co $OLDBRANCH
           fi
           if [[ "$CHANGES" != "" ]]; then
               echo Popping stashed changes
               git stash pop
           fi
       fi
   done
   cd $CURDIR
}

alias p4noedit='P4EDITOR=sleep-toucher git p4 submit'
