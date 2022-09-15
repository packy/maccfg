#!/bin/bash
#

source $HOME/.bashrc.d/enabled/spinner.sh

if [[ -d /Applications/VirtualBox.app ]]; then
    VirtualBox_Contents=/Applications/VirtualBox.app/Contents
    VirtualBoxVM_Contents=$VirtualBox_Contents/Resources/VirtualBoxVM.app/Contents
    VBoxManage=$VirtualBoxVM_Contents/MacOS/VBoxManage
    VBoxHeadless=$VirtualBoxVM_Contents/MacOS/VBoxHeadless

    VBoxLog=$HOMEBREW_PREFIX/log/VBox
    mkdir -p $VBoxLog

    function vbox-logrotate () {
        local LOG=$1
        local CONF=$VBoxLog/logrotate.conf
        touch $LOG
        local FILES=$VBoxLog/*/*.log
        mkdir -p $HOMEBREW_PREFIX/var/lib
        cat -> $CONF <<EOF
compress
compresscmd $HOMEBREW_PREFIX/bin/7z
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

    function vbox-vm-exists () {
        vbox-list | grep -q "$1"
    }

    function vbox-vm-is-running () {
        vbox-running | grep -q "$1"
    }

    function vbox-vm-prop () {
        local VM="$1"
        local PROP="$2"
        case "$PROP" in
            GuestIP) PROP="/VirtualBox/GuestInfo/Net/0/V4/IP" ;;
            NoLoggedInUsers) PROP="/VirtualBox/GuestInfo/OS/NoLoggedInUsers" ;;
        esac
        $VBoxManage guestproperty get "$VM" "$PROP"
    }

    function vbox-vm-is-booted () {
        local VM="$1"
        vbox-vm-prop "$VM" NoLoggedInUsers | grep -q 'Value: '
    }

    function vbox-log-file () {
        local VM="$1"
        local LOGDIR=$VBoxLog/$VM
        mkdir -p "$LOGDIR"
        echo $LOGDIR/$VM.log
    }

    function vbox-headless () {
        local VM="$1"
        if vbox-vm-exists; then
            if ! vbox-vm-is-running $VM; then
                local LOG=$(vbox-log-file $VM)
                echo Logging to $LOG
                vbox-logrotate $LOG
                date +'== Started %Y-%m-%d %H:%M:%S ==' >> $LOG
                (nohup bash -c "$VBoxHeadless --startvm \"$VM\" 2>&1" >> $LOG &)

                # wait for the guest to have an IPv4 address
                select_spinner circle2
                start_spinner "Starting vm $VM..."
                while ! vbox-vm-is-booted "$VM"; do
                    sleep 0.5
                done
                stop_spinner $?
            else
                (>&2 echo $VM is already running)
            fi
        else
            (>&2 echo $VM does not exist)
        fi
    }

    function vbox-off () {
        local VM="$1"
        if vbox-vm-exists; then
            if vbox-vm-is-running $VM; then
                local LOG=$(vbox-log-file $VM)
                echo Powering off... | tee -a $LOG
                $VBoxManage controlvm "$VM" acpipowerbutton 2>&1 | tee -a $LOG

                # wait for the guest to have an IPv4 address
                select_spinner circle2
                start_spinner "Stopping vm $VM..."
                while vbox-running | grep -q "$VM"; do
                    sleep 0.5
                done
                stop_spinner $?
                date +'== Stopped %Y-%m-%d %H:%M:%S ==' >> $LOG
            else
                (>&2 echo $VM is not running)
            fi
        else
            (>&2 echo $VM does not exist)
        fi
    }

    function vbox-list () {
        $VBoxManage list vms
    }

    function vbox-running () {
        $VBoxManage list runningvms
    }

    function vbox-guest-ip () {
        local VM="$1"
        if vbox-vm-exists; then
            if vbox-vm-is-running $VM; then
                vbox-vm-prop "$VM" GuestIP | awk '{ print $2 }'
            else
                (>&2 echo $VM is not running)
            fi
        else
            (>&2 echo $VM does not exist)
        fi
    }
fi
