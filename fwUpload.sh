
#!/bin/sh
## get updated fw file from kissoz.dk and upload it to the
## Kissoz modem
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


