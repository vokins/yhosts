#!/bin/sh 

#删除定时脚本的修改内容
http_username=`nvram get http_username`
sed -i '/\/dns\//d' /etc/crontabs/$http_username

#删除缓存文件夹
rm -rf /etc/dnsmasq.d/dnsfq.conf
rm -rf /etc/dnsmasq.d/ip.conf
rm -rf /etc/dnsmasq.d/union.conf

#重启dnsmasq
/etc/init.d/dnsmasq restart

echo " 已还原"