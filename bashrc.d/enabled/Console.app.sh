#!bash

function Console.app () {
  /Applications/Utilities/Console.app/Contents/MacOS/Console "$*" >/dev/null 2>&1 &
}
