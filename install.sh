#!/bin/bash

# update the Command Line Tools for Xcode
xcode-select --install

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

# if I haven't generated an SSH key for this machine yet,
# do so and prompt me to install it at GitHub
cd $HOME/.ssh
if [[ ! -f id_rsa ]]; then
  ssh-keygen -t rsa
  pbcopy < id_rsa.pub
  open https://github.com/settings/ssh/new
  echo "Your new ssh key is in the clipboard; add it to GitHub"
  read -p "Press [Enter] to continue"
fi

# make a directory to hold git repos
mkdir $HOME/git
cd $HOME/git

# clone this project
git clone --recursive https://github.com/packy/maccfg.git
cd maccfg

# make sure my PERSONAL email is set for this repo,
# since my global email is probably my employer's
git config user.email "PackyAnderson@gmail.com"

# install it!
make install
