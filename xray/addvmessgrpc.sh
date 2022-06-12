#!/bin/bash
# Created By wisnu cokro satrio
clear

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

MYIP=$(wget -qO- ipinfo.io/ip);
clear
domain=$(cat /etc/xray/domain)

vmgrpc="$(cat ~/log-install.txt | grep -w "VMESS GRPC TLS" | cut -d: -f2|sed 's/ //g')"
#vmgrpcnon="$(cat ~/log-install.txt | grep -w "VMESS GRPC NON TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/xvless.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A Client Username Was Already Created, Please Enter New Username"
			exit 1
		fi
	done
vmgrpcnon="$(cat ~/log-install.txt | grep -w "VMESS GRPC NON TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/xvless.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A Client Username Was Already Created, Please Enter New Username"
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess-grpc-tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/xvless.json
sed -i '/#vmess-grpc-nontls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/xvless.json
cat>/etc/xray/vmess-$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${vmgrpc}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "serviceName": "gandring",
      "type": "none",
      "serverName": "${domain}",
      "tls": "tls"
}
EOF
cat>/etc/xray/vmess-$user-nontls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${vmgrpcnon}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "serviceName": "gandring",
      "type": "none",
      "serverName": "${domain}",
      "tls": "none"
}
EOF
vmessgrpc_base641=$( base64 -w 0 <<< vmess_json1)
vmessgrpcnon_base642=$( base64 -w 0 <<< $vmess_json2)
vmessgrpc="vmess://$(base64 -w 0 /etc/xray/vmess-$user-tls.json)"
vmessgrpcnon="vmess://$(base64 -w 0 /etc/xray/vmess-$user-nontls.json)"
systemctl restart xvless
systemctl restart xray
service cron restart
clear
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m  🔰 AKUN VMESS GRPC 🔰   \e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Remarks : ${user}"
echo -e "Host : ${domain}"
echo -e "IP : ${MYIP}"
echo -e "Port TLS : ${vmgrpc}"
echo -e "Port none TLS : ${vmgrpcnon}"
echo -e "Id : ${uuid}"
echo -e "AlterId : 0"
echo -e "Security : auto"
echo -e "Network : grpc"
echo -e "Host : ${domain}"
echo -e "serviceName : gandring"
echo -e "Expired On : $exp"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "GRPC TLS: ${vmessgrpc}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "GRPC NONTLS: ${vmessgrpcnon}"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;46m🔰LUXURY EDITION ZEROSSL🔰\e[m"   
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
