#!bash

alias ssh-pubkeyinfo='ssh-keygen -lf'
alias ssh-proxy='ssh -D 8080'

function vnc-ssh-tunnel () {
  HOST=$1
  FIREWALL=$2
  ssh -f -L 5999:$HOST:5900 $FIREWALL "sleep 10"
  open vnc://localhost:5999
}

function vnc-ssh-home () {
  HOST=$1
  FW=${2:-babs}
  vnc-ssh-tunnel $HOST.home.packay.com $FW.packay.com
}

alias vnc-ssh-kirby='vnc-ssh-home kirby'
alias vnc-ssh-speedy='vnc-ssh-home speedy'
