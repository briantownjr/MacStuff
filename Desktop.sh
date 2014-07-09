#!/bin/bash
#sets desktop image for computers

export COMPNAMES=`scutil --get ComputerName`
if [ $COMPNAMES = ‘MH014’* ]; then osascript -e "tell application \"System Events\" to set picture of every desktop to \"/Library/Desktop Pictures/MacLabDesktop.jpg\""; else osascript -e "tell application \"System Events\" to set picture of every desktop to \"/Library/Desktop Pictures/HVPAdesk.jpg\""; fi