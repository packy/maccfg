#!/usr/bin/env bash

function file_alias () {
  FILE="$1"
  DIR="$2"
  NEWNAME="$3"
  BASE=$(basename "$FILE")
  [[ ! -f "$FILE" ]] && [[ ! -d "$FILE" ]] && return
  [[ ! -d "$DIR" ]] && return

  if [[ "$NEWNAME" != "" ]]; then
    if [[ "$NEWNAME" == "ChromeApp" ]]; then
      NEWNAME=$(get_ChromeAppName "$FILE")
      BASE="$NEWNAME.app"
    fi
  elif [[ "$BASE" =~ \.app$ ]]; then
    NEWNAME="$(echo "$BASE" | perl -pe 's/\.app$//;')"
  fi

  [[ -f "$DIR/$BASE" ]] && return
  [[ ! -z "$NEWNAME" ]] && [[ -f "$DIR/$NEWNAME" ]] && return

osascript >/dev/null <<END_SCRIPT
tell application "Finder"
   make alias file to POSIX file "$FILE" at POSIX file "$DIR"
end tell
END_SCRIPT

  if [[ "$NEWNAME" != "" ]]; then
    mv "$DIR/$BASE" "$DIR/$NEWNAME"
  fi
  unset FILE DIR NEWNAME
}

function get_ChromeAppName() {
  FILE="$1"
  defaults read "$FILE/Contents/Info.plist" \
    | perl -ne 'if (/CrAppModeShortcutName\s+=\s+"?([^";]+)"?/) { print $1 };'
}

function make_vncloc() {
  VNCHOST=$1
  FILE="$SCREEN_SHARING_APP_SUPPORT/${VNCHOST}.vncloc"
  [[ -f "$FILE" ]] && return
  cat >"$FILE" <<END_VNCLOC
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>URL</key>
  <string>vnc://${VNCHOST}._rfb._tcp.local</string>
  <key>restorationAttributes</key>
  <dict>
    <key>autoClipboard</key>
      <true/>
    <key>isFullScreen</key>
      <false/>
    <key>quality</key>
      <integer>3</integer>
    <key>scalingMode</key>
      <true/>
    <key>selectedScreenIndex</key>
      <integer>107202386985280</integer>
    <key>targetAddress</key>
      <string>vnc://${VNCHOST}._rfb._tcp.local</string>
    <key>windowFrame</key>
      <string>{{1080, 817}, {1680, 1072}}</string>
  </dict>
</dict>
</plist>
END_VNCLOC

  file_alias "$FILE" "$RDC"
  mv "$RDC/${VNCHOST}.vncloc" "$RDC/_${VNCHOST}"
}

# first, install XMenu
if [[ ! -d "/Applications/XMenu.app" ]]; then
  echo Installing XMenu
  mas install 419332741
else
  echo XMenu already installed
fi

export XMENU="$HOME/Library/Application Support/XMenu"
export CHROME_APP="$HOME/Applications/Chrome Apps.localized"
export APP_SUPPORT="$HOME/Library/Application Support"
export SCREEN_SHARING_APP_SUPPORT="$APP_SUPPORT/Screen Sharing"

echo Making sure the directories are set up...
export CUSTOM="$XMENU/Custom";       mkdir -p "$CUSTOM"
export BOOKS="$CUSTOM/Books";        mkdir -p "$BOOKS"
export BROWSERS="$CUSTOM/Browsers";  mkdir -p "$BROWSERS"
export RDC="$CUSTOM/Remote Desktop"; mkdir -p "$RDC"
export UTIL="$CUSTOM/Utilities";     mkdir -p "$UTIL"

echo Installing aliases to utilities...
file_alias "/Applications/AppCleaner.app"                "$UTIL"
file_alias "/Applications/Disk Inventory X.app"          "$UTIL"
file_alias "/Applications/Utilities/Disk Utility.app"    "$UTIL"
file_alias "/Applications/Utilities/Grab.app"            "$UTIL"
file_alias "/Applications/Image Capture.app"             "$UTIL"
file_alias "/Applications/Utilities/Keychain Access.app" "$UTIL"
file_alias "/Applications/Utilities/Script Editor.app"   "$UTIL"

# aliases to remote desktop utilities
file_alias "$CHROME_APP/Default gbchcmhmhahfdphkhkmpfmihenigjmpp.app" "$RDC" ChromeApp # Google Remote Desktop
file_alias "/System/Library/CoreServices/Applications/Screen\ Sharing.app" "$RDC"

# make aliases to other macs I own
for HOST in speedy kirby furball; do
  if [[ ! "$HOSTNAME" =~ "$HOST" ]]; then # don't alias our own host
    make_vncloc $HOST
  fi
done

# browser aliases
for BROWSER in "Google Chrome" "Google Chrome Canary" "Safari" \
               "Firefox" "Citrio" "Vivaldi"; do
  DIR="/Applications/$BROWSER.app"
  if [[ -d "$DIR" ]]; then
    file_alias "$DIR" "$BROWSERS"
  fi
done

# aliases in main dropdown
file_alias "$CHROME_APP/Default gaedmjdfmmahhbjefcbgaolhhanlaolb.app" "$CUSTOM" ChromeApp # Authy
file_alias "$CHROME_APP/Default fahmaaghhglfmonjliepjlchgpgfmobi.app" "$CUSTOM" ChromeApp # Google Play Music
file_alias "/Applications/Calculator.app"   "$CUSTOM"
file_alias "/Applications/GIMP.app"         "$CUSTOM"
file_alias "/Applications/KeePassX.app"     "$CUSTOM"
file_alias "/Applications/Keka.app"         "$CUSTOM"
file_alias "/Applications/p4merge.app"      "$CUSTOM"
file_alias "/Applications/Resilio Sync.app" "$CUSTOM"
