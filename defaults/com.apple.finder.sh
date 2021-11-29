#!/usr/bin/env bash

# Finder > Preferences > Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder > Preferences > Show warning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder > View > As List
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder > View > Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true

killall Finder > /dev/null 2>&1
