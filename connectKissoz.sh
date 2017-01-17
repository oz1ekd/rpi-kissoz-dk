#!/bin/sh
#
# stop KISS mode and connect to serial port
#
# send KISS reset
sudo echo -en '\xc0\xff\xc0\xc0\xff\xc0\xc0\x0d' > /dev/serial0
#  Connect to KissOZ HW
screen -S KissOZ -d -m /dev/serial0 115200
screen  -S KissOZ -p 0 -X stuff "^Minfo^M"
screen -r -S KissOZ
