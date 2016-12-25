# rpi-kissoz-dk
Raspberry Pi distrubution with APRX for KissOZ HW v4 Digipeater &amp; iGate

##############################################################################
## make Kissoz RPI sd-card with Raspbian Jessie from scratch
## This is the description how the sd-card file from Kissoz.dk 
## If this file is in /boot/ then all the following has been done.
## although this setup is made for the Kissoz HW v4 the setup is usuable
## too all that use the GPIO serial port on a RPI both Rpi3 and ealier 
## without any changes.
## After installing and configuring the image was made and shrinked with the
## help of http://www.aoakley.com/articles/2015-10-09-resizing-sd-images.php
##
## OZ1EKD - Svend Stave December 2016
##############################################################################

## IMPORTANT! : Your iGate will not work if you do not add you own passcode 
##              in the aprx.conf file

##############################################################################
## On a windows PC:
## download and install putty.exe (you will need it)
https://the.earth.li/~sgtatham/putty/latest/x86/putty-0.67-installer.msi

## download and install "win32diskimager" Shall be used to write the raspbian image to an sd-card
https://sourceforge.net/projects/win32diskimager/?source=typ_redirect

## download the "raspbian jessie" package, the lite edition is just fine 
https://downloads.raspberrypi.org/raspbian_lite_latest

## use win32diskimager.exe to copy the disk image to the SD-card

## after writing the image to the sd-card make a file named "ssh" in the root directory - 
## this will make sure that SSH server is started, so you dont need to connect a screen and keyboard.

## Insert the card in your RPI connect it to your LAN
## and power up.
## Wait for the PI tp boot, find the PI's IP address
## on your network. 
## (can often be found by looking in your routers DCHP list)
## Login to your RPI with SSH, (pytty is great)
## user: pi Password: raspberrypi


##############################################################################
## setup the Serial port for use with the KissOZ V4
##############################################################################

## change you RPI hostname from kissoz-digi to something else(if you want to):
sudo nano /etc/hostname 
## change the line:
## kissoz-digi

sudo nano /etc/hosts
## change the line:
## 127.0.1.1       kissoz-digi

## change you password !!!
passwd 
old passwd: raspberry
new: !GoodPW1
new again: !goodPW1

## Enable the serial uart on gpio: 
## edit the file /boot/config.txt
sudo nano /boot/config.txt
## add the following line to the end of the file:
enable_uart=1

##################################
## disable console on serial port
## for RPIx < RPI3
sudo systemctl stop serial-getty@ttyAMA0.service
sudo systemctl disable serial-getty@ttyAMA0.service
## for RPI3
sudo systemctl stop serial-getty@ttyS0.service
sudo systemctl disable serial-getty@ttyS0.service

##################################
## in the file /boot/cmdline.txt remove "console=serial0,115200" the file 
sudo nano /boot/cmdline.txt
## change from
dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait
## to
dwc_otg.lpm_enable=0 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait

##################################
## update the PI
sudo apt-get update
sudo apt-get upgrade

##################################
## install screen - it will come in handy
sudo apt-get install screen

##################################
## install xmodem used to update the KissOZ HW
sudo apt-get install lrzsz

##############################################################################
## get the aprx package, right now the latest is 2.9.0 and install it
## download http://thelifeofkenneth.com/aprx/debs/aprx_2.9.0_raspi.deb on the pi
wget http://thelifeofkenneth.com/aprx/debs/aprx_2.9.0_raspi.deb
## install the package:
sudo dpkg -i aprx_2.9.0_raspi.deb


## edit /etc/aprx.conf
## read the manual located in /home/pi or
## http://thelifeofkenneth.com/aprx/aprx-manual.pdf
## the original distributed conf file i located at:
## /etc/aprx.conf-install
sudo nano /etc/aprx.conf

## change the callsign:
mycall  KISSOSDK
## to something useful like
mycall  OZ9XXX-1

## in the <aprsis> section change 
passcode -1

## to your passcode
passcode 12345 // get it from the internet - ask a friend

## change your location use aprs.fi to help you find the right coordinates
## just place the mouse on the map and read the coordiantes near the top
myloc lat 5552.70N lon 01235.42E

## and comment/uncomment the relevant aprs2 server
## you can use another server like denmark.aprs2.net but in case of server outage if you are not using the standard port you will come offline

server denmark.aprs2.net 14580

#server   rotate.aprs2.net
#server   euro.aprs2.net
#server   asia.aprs2.net
#server   noam.aprs2.net
#server   soam.aprs2.net
#server   aunz.aprs2.net

## add a range filter usually 50Km is good

filter m/50

## Comment out log files (unless you need them for a short time) logging will strees the SD-card too much
#rflog /var/log/aprx/aprx-rf.log
#aprxlog /var/log/aprx/aprx.log
#dprslog /var/log/aprx/dprs.log


## add a section like this one:

<interface>
   serial-device /dev/serial0  115200 8n1    KISS
   timeout 300                  # 5 minutes
   initstring      "\x0dKISS ON\x0d"

   #callsign     $mycall  # callsign defaults to $mycall
   #tx-ok        false    # transmitter enable defaults to false
   #telem-to-is  true # set to 'false' to disable
</interface>

## Note the interface /dev/serial0 - this is not the normal one to see, 
## but since RPI3 thais has been added to make it the same on both RPIx and RIP3

## edit the beacon text
beacon symbol "I#" $myloc comment "Standard config by Kissoz.dk TX digi/iGate sysop: N0CALL"

## everything else can be default for now

##################################
## edit the /etc/defailt/aprx file
sudo nano /etc/default/aprx

## change 
STARTAPRX="no"
## to
STARTAPRX="yes"

##################################
## important for aprx to start 
sudo systemctl daemon-reload

##################################
## allow  user pi to use serial port
sudo usermod -aG tty pi

##################################
## allow  user pi to use manipulate the GPIO's
sudo usermod -aG gpio pi

##################################
## add some more useful ls aliases
## add file  /etc/profile.d/z_local_aliases.sh
sudo nano /etc/profile.d/z_local_aliases.sh
# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

##############################################################################
## add some helper scripts and files in /home/pi
## when logging in you automatically use /home/pi

##################################
nano doscreen.sh
##################################

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

##
chmod 755 doscreen.sh

##################################
nano fwUpload.sh
##################################

#!/bin/sh
## get updated fw file from kissoz.dk and upload it to the Kissoz modem
## when connected and you see a prompt type:
## reset
## wait for prompt boot>
## press load app

if [ ! $1 ]
then
  echo You must enter the version number of the file to upload
  exit
fi
echo

rm KissozV4_KissOZHW4*.koz
wget https://www.kissoz.dk/files/KissOZv4/KissozV4_KissOZHW4_$1.koz
echo
## reset the KissOZ HW
./resetKissoz.sh
sudo killall aprx
echo
echo copy the exec line:
echo :exec !! sx KissozV4_KissOZHW4_$1.koz
echo
echo startin: screen, when started
echo press CTRL-a and paste the exec line
echo "then type \"reset\" <enter> and \"load app\" <enter> to start upload"


##
chmod 755 fwUpload.sh

##################################
nano resetKissoz.sh
##################################

#!/bin/sh
## reset Kissoz HW with a HW GPIO


# GPIO numbers should be from this list
# 0, 1, 4, 7, 8, 9, 10, 11, 14, 15, 17, 18, 21, 22, 23, 24, 25
#!/bin/sh

# GPIO numbers should be from this list
# 0, 1, 4, 7, 8, 9, 10, 11, 14, 15, 17, 18, 21, 22, 23, 24, 25

# Note that the GPIO numbers that you program here refer to the pins
# of the BCM2835 and *not* the numbers on the pin header.
# So, if you want to activate GPIO7 on the header you should be
# using GPIO4 in this script. Likewise if you want to activate GPIO0
# on the header you should be using GPIO17 here.

# KissOZHW4rpi RESET
# Set up GPIO 22 and set to output
echo 22 > /sys/class/gpio/export
sleep 1
echo out > /sys/class/gpio/gpio22/direction
# RESET KissOZv4
echo 0 > /sys/class/gpio/gpio22/value
echo "reset PIN has been brought to low level"
echo 1 > /sys/class/gpio/gpio22/value
echo "reset PIN has been brought to high level"

##
chmod 755 resetKissoz.sh
