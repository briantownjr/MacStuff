#!/bin/bash
#checks for Thawspace volume and renames it then creates directory.

if [ -d /Volumes/THAWSPACE ]; then
	diskutil rename /Volumes/THAWSPACE 'Local Storage'
fi

if [ ! -d '/Volumes/Local Storage/Sites' ]; then
	mkdir '/Volumes/Local Storage/Sites'
fi

#mounts network storage

mkdir /Volumes/Network\ Storage
mount -t afp afp://username:password@path_to_url /Volumes/Network\ Storage