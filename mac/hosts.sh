#!/bin/sh

cd /tmp
rm *.temp
curl "https://raw.githubusercontent.com/vokins/yhosts/master/hosts.txt" -o "yhosts.temp"
curl "https://raw.githubusercontent.com/racaljk/hosts/master/hosts " -o "grd.temp"
curl "https://raw.githubusercontent.com/sy618/hosts/master/p " -o "p.temp"
curl "https://raw.githubusercontent.com/sy618/hosts/master/y " -o "y.temp"
sed -i "" "1,13d" grd.temp
sed -i "" "/googlesyndication/d" grd.temp
sed -i "" "/googleadservices/d" grd.temp
sed -i "" "/^#/d" grd.temp
sed -i "" "/^$/d" grd.temp
cat grd.temp|tr  "\t" " " >grd1.temp
cat grd1.temp p.temp y.temp yhosts.temp >> new.temp
sudo cp new.temp /etc/hosts
rm *.temp
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
say yHosts updated
echo "Succed..."
