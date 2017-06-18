#!bash # for emacs formatting

export PERLBREW_BIN=$( perl -e '$ENV{PERLBREW_PATH} =~ s/^.*:([^:]+)$/$1/; print $ENV{PERLBREW_PATH}' )

tlily () {
    if [ -x $PERLBREW_BIN/tlily ]; then
        OUTPUT=$()
        xrun "source $HOME/.bash_functions; set_term_profile tlily; xsize 70 80; xtitle 'packy @ RPI'; $PERLBREW_BIN/tlily"
    else
        echo Tigerlily is not installed at $PERLBREW_BIN/tlily
        return 1
    fi
}

