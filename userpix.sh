#!/bin/bash
#sets user icons for OSX
sudo dscl . create /Users/administrator picture '/Library/User Pictures/hcc.gif'

for i in `ls -l /Users/ | awk {'print $9'}`
do
	if [ $i == ArtStudent ]; then
		sudo dscl . create /Users/ArtStudent picture ‘/Library/User Pictures/HCC_Dragon.tif’
	elif [ $i == VideoStudent ]; then
		sudo dscl . create /Users/VideoStudent picture ‘/Library/User Pictures/HCC_Dragon.tif’
	elif [ $i == PhotoStudent ]; then
		sudo dscl . create /Users/PhotoStudent picture ‘/Library/User Pictures/HCC_Dragon.tif’
	elif [ $i == Student ]; then
		sudo dscl . create /Users/Student picture ‘/Library/User Pictures/HCC_Dragon.tif’
	elif [ $i == test ]; then
		sudo dscl . create /Users/test picture '/Library/User Pictures/HCC_Dragon.tif'
	fi
done