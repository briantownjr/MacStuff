#!/bin/bash

# Heavily modified 2014 Brian Town for DeepFreeze
# Credits to Alex Dale for original upload script
# original at https://jamfnation.jamfsoftware.com/discussion.html?id=10471
#Checks for thawed drive; if found thawed adds to local group in JSS and emails


if [ -f /tmp/groupxml.txt ]; then
	rm /tmp/groupxml.txt
fi

#check for Thawed or Frozen
touch /tmp/thawed.txt
echo password | sudo -S DFXPSWD=“xxpasswordxx” /Library/Application\ Support/Faronics/Deep\ Freeze/deepfreeze -u "admin" -p status | grep BOOT | awk '{ print $2}' 2>/dev/null > /tmp/thawed.txt
if grep -Fxq "THAWED" /tmp/thawed.txt ; then computername=`scutil --get ComputerName`; echo '<computer_group><computers><computer><name>'$computername'</name></computer></computers></computer_group>' >> /tmp/groupxml.txt; else echo 'no'; fi

dt=$(date)
echo $computername has been found THAWED on $dt. Adding to Static Group on JSS >> /tmp/email.txt
sendmail btown@howardcc.edu < /tmp/email.txt
export GROUPXML=`cat /tmp/groupxml.txt`
echo $GROUPXML
if [ ! -z $GROUPXML ]; then
	curl -s -k -u username:password https:url_to_JSS:8443/JSSResource/computergroups/id/6 -X PUT -HContent-type:application/xml --data $GROUPXML
fi