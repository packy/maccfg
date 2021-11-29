#!/usr/bin/env bash

# System Preferences > Dock > Minimize windows using: Scale effect
defaults write com.apple.dock mineffect -string "scale"

# System Preferences > Dock > Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# System Preferences > Dock > Automatically hide and show the Dock:
defaults write com.apple.dock autohide -bool false

# System Preferences > Dock > Show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Disable mission control
defaults write com.apple.Dock mcx-expose-disabled -bool true

# Add a 'Recent Applications' stack to the Dock
defaults write com.apple.dock persistent-others -array-add '{ "tile-data" = { "list-type" = 1; }; "tile-type" = "recents-tile"; }'

killall Dock > /dev/null 2>&1
