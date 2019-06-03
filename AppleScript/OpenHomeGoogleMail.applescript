(*
 * To the extent possible under law, Rob Mayoff has waived all copyright and
 * related or neighboring rights to "AppleScript to make Google Chrome
 * open/reload a URL". This work is published from: United States.
 * https://creativecommons.org/publicdomain/zero/1.0/
 *)

 set theUrl   to "https://mail.google.com/"
 set theEmail to "packyanderson@gmail.com"
 set theNew   to theUrl & "mail/a/?authuser=" & theEmail

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
             if theUrl is in theTab's URL and theEmail is in theTab's title then
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
         tell window 1 to make new tab with properties {URL:theNew}
     end if
 end tell
