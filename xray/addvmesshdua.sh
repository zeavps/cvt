#!/bin/bash
# Created By wisnu cokro satrio
clear

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

MYIP=$(wget -qO- ipinfo.io/ip);
clear
domain=$(cat /etc/xray/domain)
vmhdua="$(cat ~/log-install.txt | grep -w "VMESS H2C TLS " | cut -d: -f2|sed 's/ //g')"
#vmhduanon="$(cat ~/log-install.txt | grep -w "VMESS H2C NON TLS" | cut -d: -f2|sed 's/ //g')"
#none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A Client Username Was Already Created, Please Enter New Username"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess-hdua-tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
#sed -i '/#vmess-hdua-nontls$/a\### '"$user $exp"'\
#},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
cat>/etc/xray/vmess-$user-tls.json<<EOF
      {
      "v": "0",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${vmhdua}",
      "id": "${uuid}",
      "aid": "0",
      "net": "h2",
      "path": "gandring",
      #"type": "multi",
      "host": "",
      "tls": "tls"
}
EOF

#cat>/etc/xray/vmess-$user-nontls.json<<EOF
      {
      "v": "0",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${vmhduanon}",
      "id": "${uuid}",
      "aid": "0",
      "net": "h2",
      "path": "gandring",
      #"type": "multi",
      "host": "",
      "tls": "none"
#}
#EOF
vmesshdua_base641=$( base64 -w 0 <<< $vmess_json1)
#vmesshduanon_base642=$( base64 -w 0 <<< $vmess_json2)
vmesshdua="vmess://$(base64 -w 0 /etc/xray/vmess-$user-tls.json)"
#vmesshduanon="vmess://$(base64 -w 0 /etc/xray/vmess-$user-nontls.json)"
systemctl daemon-reload
systemctl restart xvless
systemctl restart xray
service cron restart
clear
echo -e ""
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m  🔰 AKUN VMESS HTTP/2 🔰 \e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks : ${user}"
echo -e "Host : ${domain}"
echo -e "IP : ${MYIP}"
echo -e "Port TLS : ${vmhdua}"
#echo -e "Port none TLS : ${vmhduanon}"
echo -e "Id : ${uuid}"
echo -e "AlterId : 0"
echo -e "Security : auto"
echo -e "Network : h2"
echo -e "Host : ${domain}"
echo -e "Path : gandring"
echo -e "Expired On : $exp"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "H2C TLS : ${vmesshdua}"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
#echo -e "H2C NONTLS : ${vmesshduanon}"   
#echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m🔰LUXURY EDITION ZEROSSL🔰\e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
