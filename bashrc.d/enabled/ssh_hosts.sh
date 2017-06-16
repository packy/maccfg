#!bash # for emacs formatting

authorize () {
  HOSTNAME=$(hostname -s)
  USER=$(whoami)
  DIR="~/.ssh"
  REMOTE_PUB="~/.ssh/id_rsa_${HOSTNAME}_${USER}.pub"
  AUTH_KEYS="~/.ssh/authorized_keys"
  cat ~/.ssh/id_rsa.pub | ssh $1@$2 "umask 077; test -d $DIR || mkdir $DIR; cat > $REMOTE_PUB; cat $REMOTE_PUB >> $AUTH_KEYS; test -x /sbin/restorecon && /sbin/restorecon $DIR $REMOTE_PUB $AUTH_KEYS"
}

forget_host () {
  TMP=/tmp/known_hosts.$$
  grep -v $1 $HOME/.ssh/known_hosts > $TMP
  mv $TMP $HOME/.ssh/known_hosts
}
