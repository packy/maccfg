#!/bin/bash

lift_Cellar () {
    if [[ ! -h $HOME/.homebrew_cellar ]]; then
        ln -sf $(brew --config | grep HOMEBREW_CELLAR | awk '{print $2}') $HOME/.homebrew_cellar
    fi
    readlink $HOME/.homebrew_cellar
}

# so Homebrew compiles git with PCRE
export USE_LIBPCRE=yes

GIT_BIN=$(which git)
HOMEBREW_CELLAR=$(lift_Cellar)
if readlink $GIT_BIN | grep -q 'Cellar/git'; then
    GIT_VERSION=$(readlink $GIT_BIN | \
        perl -pe 's{.*Cellar/git/}{}; s{/bin/git}{};')
else
    GIT_VERSION=$($GIT_BIN --version | perl -pe 's/git\s+version\s+//;')
fi
GIT_ROOT=$HOMEBREW_CELLAR/git/$GIT_VERSION
GIT_CORE=$GIT_ROOT/libexec/git-core
export PATH=$PATH:$GIT_CORE

export LESS=FRX
export GITDIR=$HOME/git

function gg () { # go git
    cd $GITDIR/$1
}

function gg_autocomplete () {
    complete -W "$( ls -F $GITDIR | grep '\/$' | sed 's/\/$//' )" gg
}
gg_autocomplete

alias gb='git branch'
alias gs='git status'
alias gd='git diff'

#
# git customizations
#

function git () {
    if [[ $EUID -eq 0 ]]; then
        echo "Don't run git as root!" 1>&2
        bash -c "exit 1"; # so the status is 1
    else
        /usr/local/bin/git "$@"
    fi
}

function is_git_dir () {
    [ -d .git ] || [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]
}

function parse_git_branch {
  WRAP=$1
  ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
  if [[ "$WRAP" = "wrap" ]] ; then
    echo "(${ref#refs/heads/})"
  else
    echo "${ref#refs/heads/}"
  fi
}

function make_git_titlebar {
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h: \w $(parse_git_branch wrap)\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac
}

newbranch () {
    if is_git_dir; then
        git branch "$@"
        echo Created git branch \"$1\"
        git checkout $1
    else
        echo Not a git dir: $(pwd)
    fi
}

_make_branch_name () {
    perl -e '$str = join "_", @ARGV; if ($ARGV[0] =~ /^\d+$/) { $str = "bug$str"; } print $str;' "$@"
}

newbug () {
    if is_git_dir; then
        git checkout master
        newbranch $(_make_branch_name "$@")
    else
        echo Not a git dir: $(pwd)
    fi
}

mvbug () {
    git branch -m bug$1 bug$2
}

renbug () {
    OLDBRANCH=$(parse_git_branch)
    git branch -m $OLDBRANCH $(_make_branch_name "$@")
}

delbug () {
    OLDBRANCH=$(parse_git_branch)
    git co master
    git up
    git branch -d $OLDBRANCH
}

edit_last () {
    xemacs $(perl -e '$foo =`git log -1 --name-only --pretty=oneline`;
                      $foo =~ s/^.*$//m; print $foo;')
}

mergebug () {
    OLDBRANCH=$(parse_git_branch)
    git co master
    git merge $OLDBRANCH
    git branch -d $OLDBRANCH
}

last_sha () {
    git log -1 --pretty='%h'
}

squash_last () {
    git commit --fixup=$(last_sha) "$@"
}

gl () {
   git log $(local_commits_only)
   printf "\n"
}

gln () {
   git ln $(local_commits_only)
   printf "\n"
}

glb () {
   BUG=parse_git_branch | perl -ne 'chomp; s/bug/bug /; print qq{$_};'
   git log --grep "$BUG"
   printf "\n"
}
glnb () {
   BUG=parse_git_branch | perl -ne 'chomp; s/bug/bug /; print qq{$_};'
   git log --name-only --grep "$BUG"
   printf "\n"
}

commit_matching ()
{
    MATCHES=$(git status --porcelain | perl -e '
        $match = shift @ARGV;
        $match = qr/$match/;
        while (<STDIN>) {
            if ( m{$match} ) {
                chomp;
                substr($_, 0, 3, q{});
                s/.+\s+->//;
                print;
            }
        }' $1)
    git commit $MATCHES
}

restore_cursor_clear_down
source_file $GIT_ROOT/etc/bash_completion.d/git-completion.bash
source_file ~/bin/gitp4_auto # experimental

git_commits_ahead () {
    DELTA=/tmp/git_upstream_status_delta.$$

    git for-each-ref --format="%(refname:short) %(upstream:short)" $(git-symbolic-ref HEAD) > $DELTA
    read local remote < $DELTA
    if [ ! -z "$remote" ]; then
        # this branch has an upstream remote
        git rev-list --left-right ${local}...${remote} -- 2>/dev/null >$DELTA || continue
        echo $(grep -c '^<' $DELTA)
    else
        git rev-list --left-right master..${local} -- 2>/dev/null >$DELTA || continue
        echo $(grep -c '^>' $DELTA)
    fi
    rm -f $DELTA
}
