#!/bin/sh

# GPIO numbers should be from this list
# 0, 1, 4, 7, 8, 9, 10, 11, 14, 15, 17, 18, 21, 22, 23, 24, 25

# Note that the GPIO numbers that you program here refer to the pins
# of the BCM2835 and *not* the numbers on the pin header.
# So, if you want to activate GPIO7 on the header you should be
# using GPIO4 in this script. Likewise if you want to activate GPIO0
# on the header you should be using GPIO17 here.

# KissOZHW4rpi RESET
# Set up GPIO 22 and set to output, only if not already setup
if [ ! -e /sys/class/gpio/gpio22 ];
then
echo exporting....
echo 22 > /sys/class/gpio/export
fi
# sleep allow export to take effect
sleep 1
echo out > /sys/class/gpio/gpio22/direction
# RESET KissOZv4
echo "0" > /sys/class/gpio/gpio22/value
echo "reset PIN has been brought to low level"
echo "1" > /sys/class/gpio/gpio22/value
echo "reset PIN has been brought to high level"
## below can be used to reset gpio22 to normal  state
## echo "22" > /sys/class/gpio/unexport
