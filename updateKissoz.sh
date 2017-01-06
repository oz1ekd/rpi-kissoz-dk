#!/bin/sh

##############################################################################
## Get this file 
wget https://raw.githubusercontent.com/oz1ekd/rpi-kissoz-dk/master/Kissoz-install-info.txt

##############################################################################
## add some helper scripts and files in /home/pi
## when logging in you automatically use /home/pi

wget https://raw.githubusercontent.com/oz1ekd/rpi-kissoz-dk/master/doscreen.sh
chmod 755 doscreen.sh

wget https://raw.githubusercontent.com/oz1ekd/rpi-kissoz-dk/master/fwUpload.sh
chmod 755 fwUpload.sh

wget https://raw.githubusercontent.com/oz1ekd/rpi-kissoz-dk/master/resetKissoz.sh
chmod 755 resetKissoz.sh