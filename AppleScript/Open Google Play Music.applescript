(*
 * To the extent possible under law, Rob Mayoff has waived all copyright and
 * related or neighboring rights to "AppleScript to make Google Chrome
 * open/reload a URL". This work is published from: United States.
 * https://creativecommons.org/publicdomain/zero/1.0/
 *)

set baseUrl to "https://play.google.com/music/listen"
set artistUrl to baseUrl & "?u=0#/artists"

tell application "Google Chrome"
    activate
    if (count every window) = 0 then
        make new window
    end if

    set found to false
    set theTabIndex to -1
    repeat with theWindow in every window
        set theTabIndex to 0
        repeat with theTab in every tab of theWindow
            set theTabIndex to theTabIndex + 1
            if baseUrl is in theTab's URL then
                set found to true
                exit repeat
            end if
        end repeat

        if found then
            exit repeat
        end if
    end repeat

    if found then
        set theWindow's active tab index to theTabIndex
        set index of theWindow to 1
    else
        tell window 1 to make new tab with properties {URL:artistUrl}
    end if
end tell

tell application "Default fahmaaghhglfmonjliepjlchgpgfmobi" -- Google Play Music
    activate
end tell
