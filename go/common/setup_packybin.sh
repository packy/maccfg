#!bash
#
# set up my personal bin directory and set up a hook to remove it when I'm done
#

if [[ ! -d $PACKYBIN ]]; then
    mkdir $PACKYBIN
fi

PACKY_IS_LOGGED_IN=$PACKYBIN/packy_is_logged_in.$$.tmp
touch $PACKY_IS_LOGGED_IN

END () {
    rm -f $PACKY_IS_LOGGED_IN
    COUNT=$(ls $PACKYBIN/packy_is_logged_in.*.tmp 2>/dev/null | wc -l)
    if [ "$COUNT" == "0" ]; then
        echo Removing $PACKYBIN
        rm -rf $PACKYBIN
    fi
}
trap END EXIT  # execute END() when the shell exits!

renamebin () {
    SOURCE=$1
    DEST=$2
    if [ -f $PACKYBIN/$SOURCE ]; then
        mv $PACKYBIN/$SOURCE $PACKYBIN/$DEST
        chmod +x $PACKYBIN/$DEST
    fi
}

renamebin ack-standalone ack

source $PACKYBIN/bash_bootstrap 2>/dev/null || \
    echo ERROR: Unable to find $PACKYBIN/bash_bootstrap >> /dev/stderr

for FILE in autodetect.pl prompt-colors.sh; do
    chmod 0755 $PACKYBIN/$FILE
done

alias ad="$PACKYBIN/autodetect.pl | less"

# print an error if we don't find these
for FILE in bash_path_functions bash_ack ; do
    source_file $PACKYBIN/$FILE err_if_not_found
done

# skip these if they're not present
for FILE in bash_ls fancy_prompt.sh bash_diskspace bash_bda ; do
    source_file $PACKYBIN/$FILE
done

export PATH=$PACKYBIN:$PATH

