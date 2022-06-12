#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Link Hosting Kalian Untuk Ssh Vpn
wisnuvpn="raw.githubusercontent.com/zeavps/main/cvt/ssh"
# Link Hosting Kalian Untuk Sstp
wisnuvpnn="raw.githubusercontent.com/zeavps/main/cvt/sstp"
# Link Hosting Kalian Untuk Ssr
wisnuvpnnn="raw.githubusercontent.com/zeavps/main/cvt/ssr"
# Link Hosting Kalian Untuk Shadowsocks
wisnuvpnnnn="raw.githubusercontent.com/zeavps/main/cvt/shadowsocks"
# Link Hosting Kalian Untuk Wireguard
wisnuvpnnnnn="raw.githubusercontent.com/zeavps/main/cvt/wireguard"
# Link Hosting Kalian Untuk Xray
wisnuvpnnnnnn="raw.githubusercontent.com/zeavps/main/cvt/xray"
# Link Hosting Kalian Untuk Ipsec
wisnuvpnnnnnnn="raw.githubusercontent.com/zeavps/main/cvt/ipsec"
# Link Hosting Kalian Untuk Backup
wisnuvpnnnnnnnn="raw.githubusercontent.com/zeavps/main/cvt/backup"
# Link Hosting Kalian Untuk Websocket
wisnuvpnnnnnnnnn="raw.githubusercontent.com/zeavps/main/cvt/websocket"
# Link Hosting Kalian Untuk Ohp
wisnuvpnnnnnnnnnn="raw.githubusercontent.com/zeavps/main/cvt/ohp"

# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
rm -f setup.sh

#if [ -f "/etc/v2ray/domain" ]; then
if [ -f "/etc/xray/domain" ]; then
echo "Script Already Installed"
exit 0
fi
mkdir /var/lib/wisnucs;
echo "IP=" >> /var/lib/wisnucs/ipvps.conf
wget https://${wisnuvpn}/cf.sh && chmod +x cf.sh && ./cf.sh
#install v2ray
wget https://${wisnuvpnnnnnn}/ins-xray.sh && chmod +x ins-xray.sh && screen -S xray ./ins-xray.sh
#install ssh ovpn
wget https://${wisnuvpn}/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
wget https://${wisnuvpnn}/sstp.sh && chmod +x sstp.sh && screen -S sstp ./sstp.sh
#install ssr
wget https://${wisnuvpnnn}/ssr.sh && chmod +x ssr.sh && screen -S ssr ./ssr.sh
wget https://${wisnuvpnnnn}/sodosok.sh && chmod +x sodosok.sh && screen -S ss ./sodosok.sh
#wget https://${wisnuvpnnnn}/ins-ssrust.sh.sh && chmod +x ins-ssrust.sh && screen -S ssws ./ins-ssrust.sh
#installwg
wget https://${wisnuvpnnnnn}/wg.sh && chmod +x wg.sh && screen -S wg ./wg.sh
#install L2TP
wget https://${wisnuvpnnnnnnn}/ipsec.sh && chmod +x ipsec.sh && screen -S ipsec ./ipsec.sh
wget https://${wisnuvpnnnnnnnn}/set-br.sh && chmod +x set-br.sh && ./set-br.sh
# Websocket
wget https://${wisnuvpnnnnnnnnn}/edu.sh && chmod +x edu.sh && ./edu.sh
# Ohp Server
wget https://${wisnuvpnnnnnnnnnn}/ohp.sh && chmod +x ohp.sh && ./ohp.sh

rm -f /root/ssh-vpn.sh
rm -f /root/sstp.sh
rm -f /root/wg.sh
rm -f /root/ss.sh
rm -f /root/ssr.sh
#rm -f /root/ins-ssrust.sh
rm -f /root/ins-xray.sh
rm -f /root/ipsec.sh
rm -f /root/set-br.sh
rm -f /root/edu.sh
rm -f /root/ohp.sh
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://t.me/zerossl

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
history -c
echo "1.2" > /home/ver
echo " "
echo "Installation has been completed!!"echo " "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;41m           🔰 SETUP SERVER BY ZEROSSL 🔰            \E[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" 
echo " 🔰 >>> Service & Port" |tee -a log-install.txt
echo " 🔰 PORT OPENSSH : 22" |tee -a log-install.txt
echo " 🔰 PORT OPENVPN TCP : 1194" |tee -a log-install.txt
echo " 🔰 PORT OPENVPN UDP : 1195" |tee -a log-install.txt
echo " 🔰 PORT OPENVPN SSL : 443" |tee -a log-install.txt
echo " 🔰 PORT STUNNEL5 : 700, 800, 500, 600" |tee -a log-install.txt
echo " 🔰 PORT DROPBEAR : 200, 300" |tee -a log-install.txt
echo " 🔰 PORT SQUID : 3128, 3228" |tee -a log-install.txt
echo " 🔰 Badvpn : 7100, 7200, 7300-7900" |tee -a log-install.txt
echo " 🔰 Nginx : 88" |tee -a log-install.txt
echo " 🔰 WIREGUARD : 591" |tee -a log-install.txt
echo " 🔰 L2TP/IPSEC VPN : 1701" |tee -a log-install.txt
echo " 🔰 PPTP VPN : 1732" |tee -a log-install.txt
echo " 🔰 SSTP VPN : 444" |tee -a log-install.txt
echo " 🔰 Shadowsocks-R : 1444-1543" |tee -a log-install.txt
echo " 🔰 SS-OBFS TLS : 2444-2943" |tee -a log-install.txt
echo " 🔰 SS-OBFS HTTP : 2944-3442" |tee -a log-install.txt
echo " 🔰 XRAY SHADOWSOCKS : 333" |tee -a log-install.txt
echo " 🔰 XRAY MTPROTO : 111" |tee -a log-install.txt
echo " 🔰 WEBSOCKET TLS : 443" |tee -a log-install.txt
echo " 🔰 WEBSOCKET NON TLS : 2082" |tee -a log-install.txt
echo " 🔰 PORT OVPNWS : 8080" |tee -a log-install.txt
echo " 🔰 OHP SSH : 8181" |tee -a log-install.txt
echo " 🔰 OHP Dropbear : 8282" |tee -a log-install.txt
echo " 🔰 OHP OpenVPN : 8383" |tee -a log-install.txt
echo " 🔰 VMESS WS TLS : 2053" |tee -a log-install.txt
echo " 🔰 VMESS WS NON TLS : 2052" |tee -a log-install.txt
echo " 🔰 VMESS GRPC TLS: 2053" |tee -a log-install.txt
echo " 🔰 VMESS GRPC NON TLS: 1000" |tee -a log-install.txt
echo " 🔰 VMESS H2C TLS : 8808" |tee -a log-install.txt
#echo " 🔰 VMESS H2C NON TLS : 3444" |tee -a log-install.txt
echo " 🔰 VMESS HTTP TLS : 8088" |tee -a log-install.txt
echo " 🔰 VMESS HTTP NON TLS : 808" |tee -a log-install.txt
echo " 🔰 VLESS XTLS : 99" |tee -a log-install.txt
echo " 🔰 VLESS WS TLS : 2087" |tee -a log-install.txt
echo " 🔰 VLESS WS NON TLS : 2086" |tee -a log-install.txt
echo " 🔰 VLESS GRPC TLS : 2083" |tee -a log-install.txt
echo " 🔰 VLESS GRPC NON TLS: 2000" |tee -a log-install.txt
echo " 🔰 VLESS H2C TLS : 8888" |tee -a log-install.txt
#echo " 🔰 VLESS H2C NON TLS : 888" |tee -a log-install.txt
#echo " 🔰 VLESS HTTP TLS : 8888" |tee -a log-install.txt
#echo " 🔰 VLESS HTTP NON TLS : 888" |tee -a log-install.txt
echo " 🔰 TROJAN GO : 8880" |tee -a log-install.txt
echo " 🔰 TROJAN GRPC : 8443" |tee -a log-install.txt
echo " 🔰 TROJAN HTTP : 880" |tee -a log-install.txt
echo " 🔰 TROJAN H2C : 888" |tee -a log-install.txt
echo " 🔰 TROJAN XTLS : 4443" |tee -a log-install.txt
echo " 🔰 TROJAN WS TLS : 2096" |tee -a log-install.txt
echo " 🔰 TROJAN WS NON TLS : 2095" |tee -a log-install.txt
echo " 🔰 SOCKS5 WEBSOCKET : 1080" |tee -a log-install.txt
echo " 🔰 SOCKS5 TCP : 999 |tee -a log-install.txt
echo " 🔰 SHADOWSOCKS TCP : 333" |tee -a log-install.txt
echo " 🔰 SHADOWSOCKS UDP : 503" |tee -a log-install.txt
echo " 🔰 SHADOWSOCKS WS TLS: 501" |tee -a log-install.txt
echo " 🔰 SHADOWSOCKS WS NON TLS : 502" |tee -a log-install.txt
echo " 🔰 SHADOWSOCKS 2022 : 212" |tee -a log-install.txt
echo " 🔰 XRAY MT PROTO : 111" |tee -a log-install.txt
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo " 🔰>> Server Information & Other Features"                  |tee -a log-install.txt
echo " 🔰 Timezone                : Asia/Jakarta (GMT +7)"        |tee -a log-install.txt
echo " 🔰 Fail2Ban                : [ON]"                         |tee -a log-install.txt
echo " 🔰 Dflate                  : [ON]"                         |tee -a log-install.txt
echo " 🔰 IPtables                : [ON]"                         |tee -a log-install.txt
echo " 🔰 Auto-Reboot             : [ON]"                         |tee -a log-install.txt
echo " 🔰 IPv6                    : [OFF]"                        |tee -a log-install.txt
echo " 🔰 Autoreboot On 04.00 GMT +7"                             |tee -a log-install.txt
echo " 🔰 Autobackup Data"                                        |tee -a log-install.txt
echo " 🔰 Restore Data"                                           |tee -a log-install.txt
echo " 🔰 Auto Delete Expired Account"                            |tee -a log-install.txt                      |tee -a log-install.txt
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;41m           🔰 ZEA KING STORE CVT VPS 🔰            \E[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo " 🔰 Installation Log --> /root/log-install.txt"             |tee -a log-install.txt
echo " Reboot 5 Sec"
sleep 5
rm -f setup.sh
reboot
