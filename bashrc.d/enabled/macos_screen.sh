#!bash # for emacs formatting

get_front_window_bounds () {
    osascript -e "tell application \"$1\" to get bounds of the front window"
}

get_screen_resolution () {
    osascript -e "tell application \"Finder\" to get bounds of window of desktop" | perl -ne '(undef, undef, $x, $y) = split /,\s+/; print "$x x $y"'
}

res () {
    case $1 in
        4k|uhd)
            screenresolution set 3840x2160x32@0
            ;;
        2560|wqxga)
            screenresolution set 2560x1600x32@0
            ;;
        1920|192|1080p)
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
        1280|128|1280w|128w|720p)
            screenresolution set 1280x720x32@60
            ;;
        1024|1k)
            screenresolution set 1024x768x32@60
            ;;
        800)
            screenresolution set 800x600x32@60
            ;;
        list)
            screenresolution list
            echo
            ;;
        *)
            echo Scripted resolutions:
            echo " + 4k"
            echo " + 2560"
            echo " + 1920"
            echo " + 1680"
            echo " + 1440"
            echo " + 1280h"
            echo " + 1280w"
            echo " + 1024"
            echo " + 800"
            echo ""
            echo "use \"res list\" to list available resolutions"
    esac
}
