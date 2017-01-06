#!/bin/sh

##############################################################################
## Get this file 

rm -f Kissoz-install-info.txt
wget https://raw.githubusercontent.com/oz1ekd/rpi-kissoz-dk/master/Kissoz-install-info.txt

##############################################################################
## add some helper scripts and files in /home/pi
## when logging in you automatically use /home/pi

rm -f doscreen.sh
wget https://raw.githubusercontent.com/oz1ekd/rpi-kissoz-dk/master/doscreen.sh
chmod 755 doscreen.sh

rm -f fwUpload.sh
wget https://raw.githubusercontent.com/oz1ekd/rpi-kissoz-dk/master/fwUpload.sh
chmod 755 fwUpload.sh

rm -f resetKissoz.reset.sh
wget https://raw.githubusercontent.com/oz1ekd/rpi-kissoz-dk/master/resetKissoz.sh
chmod 755 resetKissoz.sh