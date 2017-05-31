#!/bin/sh

#  hosts.sh
#  Created on 2017/5/31.

cd /tmp
rm *.temp
curl "https://raw.githubusercontent.com/vokins/yhosts/master/hosts.txt" -o "yhosts.temp"
curl "https://raw.githubusercontent.com/ss916/bug/master/log/bug" -o "2.temp"
curl "https://coding.net/u/scaffrey/p/hosts/git/raw/master/hosts" -o "1.temp"
sed -i "" "1,15d" 1.temp
cat 1.temp 2.temp >> 3.temp
sed -i "" "/googleadservices/d" 3.temp
sed -i "" "/^#/d" 3.temp
sed -i "" "/^$/d" 3.temp
cat 3.temp|tr  "\t" " " >grd.temp
cat yhosts.temp grd.temp >> hosts.temp
sudo cp hosts.temp /etc/hosts
rm *.temp
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
say hosts updated
echo "Succed..."
