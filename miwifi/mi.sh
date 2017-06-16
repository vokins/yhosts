cd /etc && curl -o hosts -k https://raw.githubusercontent.com/vokins/yhosts/master/hosts && cd /etc/dnsmasq.d && curl -o dnsfq.conf -k https://raw.githubusercontent.com/ss916/bug/master/dnsmasq/dnsfq && curl -o ip.conf -k https://raw.githubusercontent.com/vokins/yhosts/master/dnsmasq/ip.conf && curl -o union.conf -k https://raw.githubusercontent.com/vokins/yhosts/master/dnsmasq/union.conf && /etc/init.d/dnsmasq restart


