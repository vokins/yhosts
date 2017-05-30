#!/bin/sh

#  hosts.sh
#  Created on 2017/5/30.
#
cd /tmp
rm *.temp
curl "https://raw.githubusercontent.com/vokins/yhosts/master/hosts.txt" -o "yhosts.temp"
curl "https://raw.githubusercontent.com/racaljk/hosts/master/hosts " -o "grd.temp"
curl "https://raw.githubusercontent.com/ss916/bug/master/log/bug " -o "ss916.temp"
sed -i "" "1,13d" grd.temp
cat grd.temp ss916.temp >> new.temp
sed -i "" "/googlesyndication/d" new.temp
sed -i "" "/googleadservices/d" new.temp
sed -i "" "/^#/d" new.temp
sed -i "" "/^$/d" new.temp
cat new.temp|tr  "\t" " " >new1.temp
cat yhosts.temp new1.temp >> new2.temp
sudo cp new2.temp /etc/hosts
rm *.temp
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
say yHosts updated
echo "Succed..."
