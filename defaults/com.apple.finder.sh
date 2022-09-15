#!/usr/bin/env bash

# Finder > Preferences > Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder > Preferences > Show warning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder > View > As List
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder > View > Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true

# Enable 'natural' (Lion-style) scrolling
defaults write -g com.apple.swipescrolldirection -bool false

killall cfprefsd > /dev/null 2>&1
killall Finder > /dev/null 2>&1
