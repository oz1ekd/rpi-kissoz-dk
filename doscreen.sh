#!/bin/sh
## doscreen sends KISS reset to the serial port and starts a console 
## connected to the the KissOZ modem
## when finished press CTRL-A k - and answer yes to stop the screen connection
## then start aprx again:
## sudo aprx &
sudo killall aprx
sudo echo -en '\xc0\xff\xc0' > /dev/serial0
sudo echo -en '\xc0\xff\xc0' > /dev/serial0
sudo screen /dev/serial0 115200
