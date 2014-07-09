#!/bin/bash
#sets Safari to homage and allows new tabs and new windows to point to homepage

defaults write ~/Library/Preferences/com.apple.Safari HomePage -string www.howardcc.edu/students
defaults write ~/Library/Preferences/com.apple.Safari NewWindowBehavior -integer 0
defaults write ~/Library/Preferences/com.apple.Safari AlwaysRestoreSessionAtLaunch -bool false
defaults write ~/Library/Preferences/com.apple.Safari NewTabBehavior -integer 0