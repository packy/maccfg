#!/bin/bash

# update the Command Line Tools for Xcode
xcode-select --install

# make sure /usr/local is writable by the current user
USER=$(whoami)
if [[ ! -w /usr/local ]]; then
    echo Error: The /usr/local directory is not writable.
    echo running sudo chown -R $USER:admin /usr/local
    sudo chown -R $USER:admin /usr/local
fi

# install Homebrew if it's not installed: https://brew.sh/
if ! which brew; then
    URL=https://raw.githubusercontent.com/Homebrew/install/master/install
    ruby -e "$(curl -fsSL $URL)"
else
    brew update
fi

# disable Ctrl-Space as the shortcut for "select the previous input source"
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:60:enabled false" \
                        ~/Library/Preferences/com.apple.symbolichotkeys.plist

# if git isn't installed; use Homebrew to install it
if ! which git; then
  brew install pcre
  export USE_LIBPCRE=yes
  brew install --build-from-source git
fi

# make a directory to hold git repos
mkdir $HOME/git
cd $HOME/git

# clone this project
git clone --recursive git@github.com:packy/maccfg.git
cd maccfg

# install it!
make install
