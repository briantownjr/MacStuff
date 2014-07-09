--v1.2
--current 5/24/14
--removes Maps and iPhoto dock items

--Turns off software update, changes screensaver and screensaver message

do shell script "softwareupdate --schedule off"

do shell script "defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName 'Computer Name' path '/System/Library/Frameworks/ScreenSaver.framework/Resources/Computer Name.saver' type -int 0"

do shell script "defaults -currentHost write com.apple.ScreenSaver.Basic MESSAGE 'For computer-related issues, Please contact the IT Help Desk at x4444'"

--Changes Desktop based on computer name

do shell script "COMPNAMES=`scutil --get ComputerName`
if [[ $COMPNAMES = 'MH014'* ]]; then
	osascript -e 'tell application \"System Events\" to set picture of every desktop to \"/Library/Desktop Pictures/MacLabDeskTop.jpg\"'
else
	osascript -e 'tell application \"System Events\" to set picture of every desktop to \"/Library/Desktop Pictures/HVPAdesk.jpg\"'
fi"

do shell script "
if [ -d /Volumes/THAWSPACE ]; then
	diskutil rename /Volumes/THAWSPACE 'Local Storage'
fi"

do shell script "
if [ ! -d '/Volumes/Local Storage/Sites' ]; then
	mkdir '/Volumes/Local Storage/Sites'
fi"

set computername to do shell script "scutil --get ComputerName | cut -c1-7"
if computername is in {"HVPA185", "HVPA215", "HVPA165", "Compute"} then
	mount volume "afp://path_to_url/Network Storage" as user name "student" with password "abc123"
end if

set command to "defaults write com.apple.finder ShowMountedServersOnDesktop -bool TRUE"
do shell script command

--set loggedinuser to do shell script "whoami"
--if loggedinuser is equal to "administrator" then
--	do shell script "echo 'password' | sudo -S apachectl -k start"
--else if loggedinuser is equal to "ArtStudent" then
--	do shell script "echo 'password' | sudo -S apachectl -k start"
--else if loggedinuser is equal to "PhotoStudent" then
--	do shell script "echo 'password' | sudo -S apachectl -k start"
--else if loggedinuser is equal to "VideoStudent" then
--	do shell script "echo 'password' | sudo -S apachectl -k start"
--end if


do shell script "killall Finder"

try
	tell application "System Events" to tell UI element "iBooks" of list 1 of process "Dock"
		if not (exists) then return
		perform action "AXShowMenu"
		click menu item "Options" of menu 1
		click menu item "Remove from Dock" of menu 1 of menu item "Options" of menu 1
	end tell
end try

try
	tell application "System Events" to tell UI element "Maps" of list 1 of process "Dock"
		if not (exists) then return
		perform action "AXShowMenu"
		click menu item "Options" of menu 1
		click menu item "Remove from Dock" of menu 1 of menu item "Options" of menu 1
	end tell
end try