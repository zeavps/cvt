#!/bin/bash
echo "Tukar Domain?"
select yn in "Yes" "No"; do
    case $yn in
        Yes) make install ; break ;;
        No) exit ;;
    esac
done
clear

echo -e "Masukkan Domain"
read -p "Hostname / Domain: " host
rm -f /var/lib/wisnuvs/ipvps.conf
rm -f /etc/xray/domain
clear
mkdir /etc/xray
mkdir /var/lib/wisnucs;
clear
echo -e "Masukkan Domain Sekali Lagi"
read -p "Hostname / Domain: " host
echo "IP=$host" >> /var/lib/wisnucs/ipvps.conf
echo "IP=$host" >> /var/lib/wisnucs/ipvps.conf
echo "$host" >> /etc/xray/domain
