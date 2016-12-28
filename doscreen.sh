#!/bin/sh
## doscreen sends KISS reset to the serial port and starts a console
## connected to the the KissOZ modem
## when finished press CTRL-A k - and answer yes to stop the screen connection
## then start aprx again:
## sudo service aprx start
sudo service aprx stop
echo "When done press CTRL-A k - and answer yes to stop the screen connection."
sleep 2

#open terminal window
./connectKissoz.sh

# When screen is terminated APRX is restarted
echo "restarting aprx....."
sudo service aprx start
