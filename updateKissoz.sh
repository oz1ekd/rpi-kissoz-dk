#!/bin/sh

##############################################################################
## add some helper scripts and files in /home/pi
## when logging in you automatically use /home/pi

wget https://github.com/oz1ekd/rpi-kissoz-dk/blob/master/doscreen.sh
chmod 755 doscreen.sh

wget https://github.com/oz1ekd/rpi-kissoz-dk/blob/master/fwUpload.sh
chmod 755 fwUpload.sh

wget https://github.com/oz1ekd/rpi-kissoz-dk/blob/master/resetKissoz.sh
chmod 755 resetKissoz.sh