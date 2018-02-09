#!/bin/sh
#此脚本只适用于老毛子padavan固件
#初次运行： wget --no-check-certificate https://raw.githubusercontent.com/vokins/yhosts/master/dnsmasq/padavan.sh -O /etc/storage/dnsmasq/padavan.sh;sh /etc/storage/dnsmasq/padavan.sh
echo "————————————开始脚本—————————————"
echo " "
echo "·········写入配置信息···········"
echo "* 到“dnsmasq.conf”配置文件里指向规则文件路径"
sed -i '/\/dns\//d' /etc/storage/dnsmasq/dnsmasq.conf
cat >> /etc/storage/dnsmasq/dnsmasq.conf << EOF
addn-hosts=/etc/storage/dnsmasq/dns/hosts
conf-dir=/etc/storage/dnsmasq/dns/conf
EOF

echo "* 到定时任务crontabs里写入定时执行任务"
#五点一分执行脚本
http_username=`nvram get http_username`
sed -i '/\/dns\//d' /etc/storage/cron/crontabs/$http_username
cat >> /etc/storage/cron/crontabs/$http_username << EOF
1 5 * * * sh /etc/storage/dnsmasq/dns/start.sh
EOF

echo "* 到自定义脚本里“在 WAN 上行/下行启动后执行”写入命令，实现网络重连时自动更新dnsmasq"
sed -i '/\/dns\//d' /etc/storage/post_wan_script.sh
cat >> /etc/storage/post_wan_script.sh << EOF
sh /etc/storage/dnsmasq/dns/start.sh
EOF


#重建dns文件夹
rm -rf /etc/storage/dnsmasq/dns;mkdir -p /etc/storage/dnsmasq/dns/conf


echo "·········生成start.sh脚本···········"
cat > /etc/storage/dnsmasq/dns/start.sh << EOF
#!/bin/sh
cd /etc/storage/dnsmasq/dns/conf
echo "--- 下载dnsmasq规则"
wget --no-check-certificate https://raw.githubusercontent.com/vokins/yhosts/master/dnsmasq/ip.conf -O ip.conf;sed -i "1 i\## Download：\$(date "+%Y-%m-%d %H:%M:%S")" ip.conf
wget --no-check-certificate https://raw.githubusercontent.com/vokins/yhosts/master/dnsmasq/union.conf -O union.conf;sed -i "1 i\## Download：\$(date "+%Y-%m-%d %H:%M:%S")" union.conf

cd /etc/storage/dnsmasq/dns
echo "--- 下载AD hosts规则"
wget --no-check-certificate https://raw.githubusercontent.com/vokins/yhosts/master/hosts -O hosts

echo "…………精简AD hosts……………‥"
echo "批量删除AD hosts内不必要的域名，可大量减少hosts行数与不想要的域名。包含dnsmasq规则union.conf域名、自定义白名单white.txt（关键词，一行一条）。"
echo "* 自定义编辑白名单white.txt：/etc/storage/dnsmasq/dns/white.txt"
touch white.txt
echo "—— 提取待精简域名列表domain"
cat /etc/storage/dnsmasq/dns/conf/union.conf | sed '/#\|^ *\$/d' | awk -F/ '{print \$2}' | sed  's#^\.##g' > domain;cat white.txt >> domain
echo "—— 开始精简AD hosts……"
for abc in \$(cat domain)
do
sed -i "/^## \|^#.*201\|^#url/!{/\$abc/d}" hosts
done
wait

sed -i "1 i\## Download：\$(date "+%Y-%m-%d %H:%M:%S")" hosts
echo "完成，dnsmasq已生效"
restart_dhcpd
EOF


echo "·········生成del.sh脚本···········"
cat > /etc/storage/dnsmasq/dns/del.sh << EOF
#!/bin/sh 
echo "-- 删除dnsmasq.conf的修改内容"
sed -i -e '/\/dns\//d' /etc/storage/dnsmasq/dnsmasq.conf

echo "-- 删除定时脚本的修改内容"
http_username=`nvram get http_username`
sed -i '/\/dns\//d' /etc/storage/cron/crontabs/$http_username

echo "-- 删除自定义脚本里“在 WAN 上行/下行启动后执行”的修改"
sed -i '/\/dns\//d' /etc/storage/post_wan_script.sh

echo "--- 删除规则文件夹"
rm -rf /etc/storage/dnsmasq/dns
echo "重启dnsmasq"
restart_dhcpd
echo " 已还原"
EOF


echo " "
echo "·········执行start.sh脚本，自动下载规则文件···········"
sh /etc/storage/dnsmasq/dns/start.sh
echo " "
echo "————————————脚本结束！—————————————"
echo " "
echo "* 更新规则脚本命令： sh /etc/storage/dnsmasq/dns/start.sh"
echo "* 如需还原，只需运行命令： sh /etc/storage/dnsmasq/dns/del.sh"
