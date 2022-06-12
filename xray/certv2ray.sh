#!/bin/bash
echo start
sleep 0.5
source /var/lib/wisnucs/ipvps.conf
domain=$IP
systemctl stop xtrojan
systemctl stop xray
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.cer --keypath /etc/xray/xray.key --ecc
systemctl start xray
systemctl start xtrojan
systemctl start xvless
echo Done
sleep 0.5
clear 
status
