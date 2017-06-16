#!/bin/sh

cd /etc && rm -rf /etc/hosts && curl -o hosts -k https://raw.githubusercontent.com/vokins/yhosts/master/hosts && cd /etc/dnsmasq.d && curl -o dnsfq.conf -k https://raw.githubusercontent.com/ss916/bug/master/dnsmasq/dnsfq && curl -o ip.conf -k https://raw.githubusercontent.com/vokins/yhosts/master/dnsmasq/ip.conf && curl -o union.conf -k https://raw.githubusercontent.com/vokins/yhosts/master/dnsmasq/union.conf && /etc/init.d/dnsmasq restart

echo "* 到定时任务crontabs里写入定时执行任务"
#零点一分执行脚本
http_username=`nvram get http_username`
sed -i '/\/dns\//d' /etc/crontabs/$http_username
cat >> /etc/crontabs/$http_username << EOF
1 0 * * * sh /etc/dnsmasq.d/mi.sh
EOF

echo "* 到自定义脚本里“在 WAN 上行/下行启动后执行”写入命令，实现网络重连时自动更新dnsmasq"
sed -i '/\/dns\//d' /etc/storage/post_wan_script.sh
cat >> /etc/storage/post_wan_script.sh << EOF
sh /etc/storage/dnsmasq/dns/start.sh
EOF

echo " "
rm -rf /etc/storage/dnsmasq/dns;mkdir -p /etc/storage/dnsmasq/dns
echo "·········下载start.sh、del.sh脚本···········"
wget --no-check-certificate https://raw.githubusercontent.com/ss916/bug/master/dnsmasq/sh/start.sh -O /etc/storage/dnsmasq/dns/start.sh
wget --no-check-certificate https://raw.githubusercontent.com/ss916/bug/master/dnsmasq/sh/del.sh -O /etc/storage/dnsmasq/dns/del.sh
echo " "
echo "·········执行start.sh脚本，自动下载规则文件···········"
#chmod 775 /etc/storage/dnsmasq/dns/start.sh
sh /etc/storage/dnsmasq/dns/start.sh
echo " "
echo "————————————脚本结束！—————————————"
echo "* 如需还原修改，只需运行命令： sh /etc/storage/dnsmasq/dns/del.sh"