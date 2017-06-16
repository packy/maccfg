#!bash # for emacs formatting

get_front_window_bounds () {
    osascript -e "tell application \"$1\" to get bounds of the front window"
}

get_screen_resolution () {
    osascript -e "tell application \"Finder\" to get bounds of window of desktop" | perl -ne '(undef, undef, $x, $y) = split /,\s+/; print "$x x $y"'
}

res () {
    case $1 in
        1920|192)
            screenresolution set 1920x1080x32@60
            ;;
        1440|144)
            screenresolution set 1440x900x32@60
            ;;
        1680|168)
            screenresolution set 1680x1050x32@60
            ;;
        1280h|128h)
            screenresolution set 1280x1024x32@60
            ;;
        1280|128|1280w|128w)
            screenresolution set 1280x720x32@60
            ;;
        1024|1k)
            screenresolution set 1024x768x32@60
            ;;
        800)
            screenresolution set 800x600x32@60
            ;;
    esac
}

