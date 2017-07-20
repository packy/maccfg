#!bash

7zarc () {
    for DIR in "$@"; do
        7z a -t7z -mx=9 -m0=lzma -mfb=64 -md=32m -ms=on $DIR.7z $DIR
        trash $DIR
    done
}
