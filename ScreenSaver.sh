#!/bin/bash
#sets screen saver on macs to display message regarding help desk

defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName 'Computer Name' path '/System/Library/Frameworks/ScreenSaver.framework/Resources/Computer Name.saver' type -int 0
defaults -currentHost write com.apple.ScreenSaver.Basic MESSAGE 'For computer-related issues, Please contact the IT Help Desk at x4444'