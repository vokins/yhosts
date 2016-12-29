#!/bin/sh

cd /tmp
curl "https://raw.githubusercontent.com/vokins/yhosts/master/hosts.txt" -o "yhosts.temp"
cat yhosts.temp >> hosts.temp
sudo cp hosts.temp /etc/hosts
rm *.temp
sudo killall -HUP mDNSResponder
echo "Succed..."
