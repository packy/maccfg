#!/bin/bash
#

if [[ -d /Applications/VirtualBox.app ]]; then
    VirtualBox_Contents=/Applications/VirtualBox.app/Contents
    VirtualBoxVM_Contents=$VirtualBox_Contents/Resources/VirtualBoxVM.app/Contents
    VBoxManage=$VirtualBoxVM_Contents/MacOS/VBoxManage
    VBoxHeadless=$VirtualBoxVM_Contents/MacOS/VBoxHeadless

    VBoxLog=/usr/local/log/VBox
    mkdir -p $VBoxLog

    function vbox-logrotate () {
        local LOG=$1
        local CONF=$VBoxLog/logrotate.conf 
        touch $LOG
        local FILES=$VBoxLog/*/*.log
        mkdir -p /usr/local/var/lib
        cat -> $CONF <<EOF
compress
compresscmd /usr/local/bin/7z
compressoptions a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on
dateext

$FILES {
    rotate 5
    size 100k
}
EOF
        logrotate $CONF
    }

    alias VBoxManage=$VBoxManage
    alias vbox=$VBoxManage

    function vbox-log-file () {
        local VM="$1"
        local LOGDIR=$VBoxLog/$VM
        mkdir -p "$LOGDIR"
        echo $LOGDIR/$VM.log
    }

    function vbox-headless () {
        local VM="$1"
        local LOG=$(vbox-log-file $VM)
        echo Logging to $LOG
        vbox-logrotate $LOG
        date +'== Started %Y-%m-%d %H:%M:%S ==' >> $LOG
        (nohup bash -c "$VBoxHeadless --startvm \"$VM\" 2>&1" >> $LOG &)
    }

    function vbox-off () {
        local VM="$1"
        local LOG=$(vbox-log-file $VM)
        echo Powering off... | tee -a $LOG
        $VBoxManage controlvm "$@" acpipowerbutton |& tee -a $LOG
        date +'== Stopped %Y-%m-%d %H:%M:%S ==' >> $LOG
    }

    function vbox-list () {
        $VBoxManage list vms
    }

    function vbox-running () {
        $VBoxManage list runningvms
    }
fi
