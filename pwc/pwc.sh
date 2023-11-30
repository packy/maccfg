#!bash - for syntax highlighting

function pwc_skeleton () {
  SKELETON=$1
  FILE=$2
  if [[ ! -f $FILE ]]; then
    cp $SKELETON $FILE
  fi
  chmod +x $FILE
}

function pwc () {
  cd $HOME/git/perlweeklychallenge-club/

  # update the repository to the latest week
  if ! git remote | grep upstream >/dev/null; then
    git remote add upstream git@github.com:manwar/perlweeklychallenge-club.git
  fi
  git fetch upstream 
  git switch master
  git merge upstream/master
  git push

  # find the latest challenge directory
  CHALLENGE_DIR=$(ls -d challenge-* | tail -1)
  cd $CHALLENGE_DIR

  # set up the skeleton files
  mkdir raku
  pwc_skeleton $CFGDIR/pwc/skeleton.raku raku/ch-1.raku
  pwc_skeleton $CFGDIR/pwc/skeleton.raku raku/ch-2.raku

  mkdir perl
  pwc_skeleton $CFGDIR/pwc/skeleton.pl perl/ch-1.pl
  pwc_skeleton $CFGDIR/pwc/skeleton.pl perl/ch-2.pl

  mkdir python
  pwc_skeleton $CFGDIR/pwc/skeleton.py python/ch-1.py
  pwc_skeleton $CFGDIR/pwc/skeleton.py python/ch-2.py

  touch blog.txt
  git add .
  code .
}