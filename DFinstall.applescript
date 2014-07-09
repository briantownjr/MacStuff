--v1.2
--5/24/14
--dock settings, installs DF based on user 


--removes DFinstall hook

try
	do shell script "echo 'password' | sudo -S rm -Rf ~/.Trash/*"
end try

--VOLUME MOUNT
--mounts afp share

do shell script "
if [ -d /Volumes/Setups ]; then
	rmdir /Volumes/Setups
	diskutil unmount /Volumes/Setups
fi
mkdir /Volumes/Setups
mount -t afp afp://username:password@path_to_url/Setups/ /Volumes/Setups"


set loggedinuser to do shell script "whoami"
if loggedinuser is equal to "administrator" then
	do shell script "echo 'password' | sudo -S cp /Volumes/Setups/Images/Hookagent/com.apple.test.plist /Volumes/Macintosh\\ HD/System/Library/LaunchAgents/"
else if loggedinuser is equal to "ArtStudent" then
	do shell script "echo 'easel' | sudo -S cp /Volumes/Setups/Images/Hookagent/com.apple.test.plist /Volumes/Macintosh\\ HD/System/Library/LaunchAgents/"
else if loggedinuser is equal to "PhotoStudent" then
	do shell script "echo 'lens' | sudo -S cp /Volumes/Setups/Images/Hookagent/com.apple.test.plist /Volumes/Macintosh\\ HD/System/Library/LaunchAgents/"
else if loggedinuser is equal to "VideoStudent" then
	do shell script "echo 'tripod' | sudo -S cp /Volumes/Setups/Images/Hookagent/com.apple.test.plist /Volumes/Macintosh\\ HD/System/Library/LaunchAgents/"
end if

--Unmount Setups

do shell script "
if [ -d /Volumes/Setups ]; then
	rmdir /Volumes/Setups
	diskutil unmount /Volumes/Setups
fi"


--Disable AutoLogin
--reindex spotlight

set computername to do shell script "scutil --get ComputerName | cut -c1-7"

if computername is not in {"ST105"} then
	try
		do shell script "echo 'password' | sudo -S defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser"
	end try
else
	try
		do shell script "echo 'password' | sudo -S defaults write /Library/Preferences/com.apple.loginwindow 'autoLoginUser' 'Student'"
		do shell script "echo 'password' | sudo -S cp /Volumes/Setups/Images/ST105/kcpassword /private/etc/"
	end try
end if


try
	do shell script "
	if [ -a /.metadata_never_index ]; then
		echo 'password' | sudo -S rm /.metadata_never_index
	fi
	if [ -a /.fseventsd/no_log ]; then
		echo 'password' | sudo -S rm /.fseventsd/no_log
	fi"
end try

do shell script " 
echo 'password' | sudo -S mdutil -i on / 
echo 'password' | sudo -S rm -rf /.Spotlight*
echo 'password' | sudo -S mdutil -E /"

--enables dock zoom

tell application "System Events"
	tell dock preferences
		set properties to {magnification:true}
	end tell
end tell

--MOUSE
--Sets mouse settings 

tell application "System Events"
	
	# open Mouse preferences & set right button to Secondary
	tell application "System Preferences"
		
		activate
		reveal pane "Mouse"
		
	end tell
	
	tell application "System Events"
		
		try
			tell process "System Preferences"
				
				# set Secondary Button
				click pop up button 5 of group 1 of window "Mouse"
				click menu item "Secondary Button" of menu of pop up button 5 of group 1 of window "Mouse"
				# set Primary Button
				click pop up button 4 of group 1 of window "Mouse"
				click menu item "Primary Button" of menu of pop up button 4 of group 1 of window "Mouse"
				
			end tell
		end try
	end tell
	tell application "System Events"
		set value of slider "Tracking" of window "Mouse" of process "System Preferences" to 5
	end tell
	tell application "System Events"
		set value of slider 3 of window "Mouse" of process "System Preferences" to 1
	end tell
	tell application "System Preferences" to quit
end tell

do shell script "defaults write ~/Library/Preferences/.GlobalPreferences com.apple.swipescrolldirection -bool false"

--Setsup startuphook

--set computername to do shell script "scutil --get ComputerName | cut -c1-7"
--if computername is in {"HVPA185", "HVPA215", "Compute"} then
--	tell application "System Events" to make login item at end with properties {path:"/Library/Preferences/startuphook.app", hidden:false}
--end if

--Installation of DF

do shell script "open -a /Applications/Faronics/DFXControl.app"

tell application "Finder" to open (every window whose name is "Login")

tell application "/Applications/Faronics/DFXControl.app"
	activate
	tell application "System Events"
		keystroke "username"
		keystroke tab
		keystroke "password"
		keystroke return
		delay 1
		keystroke return
		tell application process "DFXControl"
			click button "Apply" of window "Deep Freeze"
		end tell
		set loggedinuser to do shell script "whoami"
		if loggedinuser is equal to "administrator" then
			keystroke "password"
		else if loggedinuser is equal to "ArtStudent" then
			keystroke "password"
		else if loggedinuser is equal to "VideoStudent" then
			keystroke "password"
		else if loggedinuser is equal to "PhotoStudent" then
			keystroke "password"
		end if
		keystroke return
	end tell
end tell

set computername to do shell script "scutil --get ComputerName | cut -c1-7"
if computername is in {"HVPA185", "HVPA215", "Compute"} then
	delay 600
else
	delay 100
end if

--After setup clicks ok on window and restarts

tell application "System Events"
	tell process "DFXControl"
		set frontmost to true
	end tell
end tell

tell application "System Events"
	keystroke return
end tell

tell application "/Applications/Faronics/DFXControl.app"
	quit
end tell


delay 5

do shell script "echo 'password' | sudo -S rm -r /Library/Preferences/DFinstall.app"

delay 5

tell application "Finder"
	restart
end tell

