#!bash # for emacs formatting

export PERLBREW_BIN=$( perl -e '$ENV{PERLBREW_PATH} =~ s/^.*:([^:]+)$/$1/; print $ENV{PERLBREW_PATH}' )

tlily () {
    if [ -x $PERLBREW_BIN/tlily ]; then
        xrun --title 'packy @ RPI' --height 70 --width 80 "$PERLBREW_BIN/tlily"
    else
        echo Tigerlily is not installed at $PERLBREW_BIN/tlily
        return 1
    fi
}
