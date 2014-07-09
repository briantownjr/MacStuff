--version 1.2
--Brian Town 2014
--Howard Community College 
--update 5/12/14: Changed DF portion for Mavericks packages
--update 5/24/14: Dock settings, mouse tweaks, launch agents

do shell script "sleep 20"

--creates a maclist file,finds the macaddress of the machine and looks through the list matching it to the correct name, then removes the maclist file

do shell script " echo 'password' | sudo -S touch maclist.txt"
do shell script "echo 'password' | sudo -S chmod 777 maclist.txt"
do shell script "maclists >> maclist.txt"

--COMPUTER NAME
--sets computername based on macaddress and then removes the maclist file
--If no name is found, prompts dialog box and changes name to input

do shell script "LOCALMAC=`ifconfig en0 | grep 'ether ' | cut -c7-24`
COMPNAME=`cat maclist.txt | grep $LOCALMAC | awk {'print $2'}`
if [[ -z $COMPNAME ]]; then
	echo 'password' | sudo -S scutil --set ComputerName NotFound
else
	echo 'password' | sudo -S scutil --set ComputerName $COMPNAME
fi"

do shell script " echo 'password' | sudo -S rm maclist.txt"

set computername to do shell script "scutil --get ComputerName"
if computername = "NotFound" then
	tell application "Finder" to activate
	display dialog "Please Enter Computer Name: " default answer ""
	set theAnswer to (text returned of result)
	do shell script "scutil --set ComputerName " & theAnswer
	display dialog "Computer Name set"
end if

--VOLUME MOUNT
--mounts afp share

do shell script "
if [ -d /Volumes/Setups ]; then
	rmdir /Volumes/Setups
	diskutil unmount /Volumes/Setups
fi
mkdir /Volumes/Setups
mount -t afp afp://username:password@path_to_url/Setups/ /Volumes/Setups"

--FILE COPY
--Copies over image files

do shell script "echo 'password' | sudo -S cp /Volumes/Setups/Images/HCC_Dragon.tif '/Library/User Pictures/'
sudo cp /Volumes/Setups/Images/hcc.gif '/Library/User Pictures/hcc.gif'
sudo cp /Volumes/Setups/Images/HCC_Dragon_Mac1280.jpg '/Library/Desktop Pictures/'
sudo cp /Volumes/Setups/Images/MacLabDeskTop.jpg '/Library/Desktop Pictures/'
sudo cp /Volumes/Setups/Images/HVPAdesk.jpg '/Library/Desktop Pictures/'"

--Copies over hook files

do shell script "echo 'password' | sudo -S cp /Volumes/Setups/Images/DFagent/com.apple.test.plist /Library/LaunchAgents/"

do shell script "echo 'password' | sudo -S cp -r /Volumes/Setups/Images/startuphook.app /Library/Preferences/"
do shell script "echo 'password' | sudo -S cp -r /Volumes/Setups/Images/DFinstall.app /Library/Preferences"

--modifies database for Accessibility
do shell script "echo 'password' | sudo -S cp /Volumes/Setups/Images/TCC.db /Library/Application\\ Support/com.apple.TCC/"

--Checks version of OSX running .Need to fix issue.

--do shell script "VersionNum=`sw_vers -productVersion`
--if [[ $VersionNum = '10.9'* ]]; then
--	DF40loc='/Volumes/Setups/Deepfreeze/DF_Mavericks/DF_MAV_40GBTHAW.pkg'
--	DFloc='/Volumes/Setups/Deepfreeze/DF_Mavericks/DF_MAV_NOTHAW.pkg'
--else
--	DF40loc='/Volumes/Setups/Deepfreeze/40GBThaw.pkg'
--	DFloc='/Volumes/Setups/Deepfreeze/NoThaw.pkg'
--fi"


--Copies over Deep Freeze Packages

do shell script "COMPNAMES=`scutil --get ComputerName`
if [[ $COMPNAMES = 'HVPA185'* ]] || [[ $COMPNAMES = 'HVPA215'* ]]
then
	echo 'password' | sudo -S cp /Volumes/Setups/Deepfreeze/DF_Mavericks/DF_Mav_40GBTHAW.pkg /Applications/
else
	echo 'password' | sudo -S cp /Volumes/Setups/Deepfreeze/DF_Mavericks/DF_MAV_NOTHAW.pkg /Applications/
fi"

do shell script "echo 'password' | sudo -S cp /Volumes/Setups/PowerSave/PowersaveMav.pkg /Applications/"

--cp /Volumes/Setups/Deepfreeze/DF_Mavericks/DF_MAV_NOTHAW.pkg /Applications/
--Copies over Apache

do shell script "echo 'password' | sudo -S cp /Volumes/Setups/Images/php.ini /etc/php.ini
sudo cp /Volumes/Setups/Images/httpd.conf /etc/apache2/httpd.conf"


do shell script "defaults write ~/Library/Preferences/.GlobalPreferences com.apple.swipescrolldirection -bool false"

--enables dock zoom

tell application "System Events"
	tell dock preferences
		set properties to {magnification:true}
	end tell
end tell

--Safari Settings

do shell script "defaults write com.apple.safari HomePage 'http://www.howardcc.edu/Students'
defaults write com.apple.safari NewTabBehavior '0'
defaults write com.apple.safari NewWindowBehavior '0'"


--Turns wifi on or off

set computername to do shell script "scutil --get ComputerName | cut -c1-7"
if computername is not in {"HVPA165"} then
	do shell script "networksetup -setairportpower en1 off"
else
	do shell script "networksetup -setairportpower en1 on"
end if

--hides HD

do shell script "echo 'password' | sudo -S chflags hidden '/Volumes/Macintosh HD'
killall Finder"

--Gatekeeper Disable
--Gatekeeper is the annoying UAC type thing

do shell script "echo 'password' | sudo -S spctl --master-disable"

--sets autologin for reboot
--kcpassword stores encrypted password for account to autologin

--do shell script "echo 'password' | sudo -S defaults write /Library/Preferences/com.apple.loginwindow 'autoLoginUser' 'administrator'"
--do shell script "echo 'password' | sudo -S cp /Volumes/Setups/Images/kcpassword /private/etc/"

--DeepFreeze 40GB Install

do shell script "echo 'password' | sudo -S installer -pkg /Applications/PowersaveMav.pkg -target /"

set computername to do shell script "scutil --get ComputerName | cut -c1-7"
if computername is in {"HVPA185", "HVPA215", "Compute"} then
	do shell script "echo 'password' | sudo -S installer -pkg /Applications/DF_MAV_40GBTHAW.pkg -target /"
else
	do shell script "echo 'password' | sudo -S installer -pkg /Applications/DF_MAV_NOTHAW.pkg -target /"
end if


--Unmount Setups

do shell script "
if [ -d /Volumes/Setups ]; then
	rmdir /Volumes/Setups
	diskutil unmount /Volumes/Setups
fi"


delay 10

tell application "Finder"
	restart
end tell
























