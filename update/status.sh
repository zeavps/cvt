#!/bin/bash
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
yl='\e[32;1m'
bl='\e[36;1m'
gl='\e[32;1m'
rd='\e[31;1m'
mg='\e[0;95m'
blu='\e[34m'
op='\e[35m'
or='\033[1;33m'
bd='\e[1m'
color1='\e[031;1m'
color2='\e[34;1m'
color3='\e[0m'
# Getting

AKTIF="$gl Aktif [ ${green}Running${NC} ]"
ERROR="$rd Error [ ${red}Not Running${NC} ]"

dahlah=()
mantap=()
declare ingfo=()            
#=====================================
status01=$(systemctl status dropbear         | grep -i "active (running)")
status02=$(systemctl status sshd             | grep -i "active (running)")
status03=$(systemctl status stunnel5         | grep -i "active (running)")
status04=$(systemctl status openvpn          | grep -i "active (exited)")
status05=$(systemctl status dropbear-ohp     | grep -i "active (running)")
status06=$(systemctl status openvpn-ohp      | grep -i "active (running)")
status07=$(systemctl status ssh-ohp          | grep -i "active (running)")
status08=$(systemctl status ipsec            | grep -i "active (running)")
status09=$(systemctl status accel-ppp        | grep -i "active (running)")
status10=$(systemctl status pptpd            | grep -i "active (running)")
status11=$(systemctl status xl2tpd           | grep -i "active (running)")
status12=$(systemctl status nginx            | grep -i "active (running)")
status13=$(systemctl status squid            | grep -i "active (running)")
status14=$(systemctl status cron             | grep -i "active (running)")
status15=$(systemctl status fail2ban         | grep -i "active (running)")
status16=$(systemctl status vnstat           | grep -i "active (running)")
status17=$(systemctl status sslh             | grep -i "active (running)")
status18=$(systemctl status privoxy          | grep -i "active (running)")
status19=$(systemctl status ws-tls           | grep -i "active (running)")
status19=$(systemctl status ws-nontls        | grep -i "active (running)")
status20=$(systemctl status ovpnws           | grep -i "active (running)")
status21=$(systemctl status wstunnel         | grep -i "active (running)")
status22=$(systemctl status wg-quick@wg0     | grep -i "active (exited)")
status23=$(systemctl status shadowsocks-libev| grep -i "active (running)")
status23=$(systemctl status shadowsocks-libev| grep -i "active (running)")
status24=$(systemctl status ssrmu            | grep -i "active (running)")
#v2ray=$(systemctl status v2ray              | grep -i "active (running)")
#v2ray=$(systemctl status v2ray              | grep -i "active (running)")
#v2ray=$(systemctl status v2ray              | grep -i "active (running)")
#v2ray=$(systemctl status v2ray              | grep -i "active (running)")
#v2ray=$(systemctl status v2ray              | grep -i "active (running)")
#v2ray=$(systemctl status v2ray              | grep -i "active (running)")
status25=$(systemctl status xray             | grep -i "active (running)")
status26=$(systemctl status xray             | grep -i "active (running)")
status27=$(systemctl status xray             | grep -i "active (running)")
status28=$(systemctl status xray             | grep -i "active (running)")
status29=$(systemctl status xray             | grep -i "active (running)")
status30=$(systemctl status xray             | grep -i "active (running)")
status31=$(systemctl status xray             | grep -i "active (running)")
status32=$(systemctl status xray             | grep -i "active (running)")
status33=$(systemctl status xray             | grep -i "active (running)")
status34=$(systemctl status xray             | grep -i "active (running)")
status35=$(systemctl status xray             | grep -i "active (running)")
status36=$(systemctl status xray             | grep -i "active (running)")
status37=$(systemctl status xray             | grep -i "active (running)")
status38=$(systemctl status xray             | grep -i "active (running)")
status39=$(systemctl status xray             | grep -i "active (running)")
status40=$(systemctl status xray             | grep -i "active (running)")
status41=$(systemctl status trojan-go        | grep -i "active (running)")
status42=$(systemctl status xray             | grep -i "active (running)")
status43=$(systemctl status xray             | grep -i "active (running)")
status44=$(systemctl status xray             | grep -i "active (running)")
status45=$(systemctl status xray             | grep -i "active (running)")
status46=$(systemctl status xray             | grep -i "active (running)")
status47=$(systemctl status xray             | grep -i "active (running)")
status48=$(systemctl status xray             | grep -i "active (running)")
status49=$(systemctl status xray             | grep -i "active (running)")
status50=$(systemctl status xray             | grep -i "active (running)")
status51=$(systemctl status xray             | grep -i "active (running)")
status52=$(systemctl status xray             | grep -i "active (running)")
#======================================
if [[ $status01 == "" ]]; then
      sstatus01=$ERROR
      ingfo+=("DROPBEAR")
      dahlah+=("err1")
else
      sstatus01=$AKTIF
      mantap+=("hore1")
fi
if [[ $status02 == "" ]]; then
      sstatus02=$ERROR
      ingfo+=("OPENSSH")
      dahlah+=("err2")
else
      sstatus02=$AKTIF
      mantap+=("hore2")

fi
if [[ $status03 == "" ]]; then
      sstatus03=$ERROR
      ingfo+=("STUNNEL5")
      dahlah+=("err3")
else
      sstatus03=$AKTIF
      mantap+=("hore3")
fi
if [[ $status04 == "" ]]; then
      sstatus04=$ERROR
      ingfo+=("OPENVPN")
      dahlah+=("err4")
else
      sstatus04=$AKTIF
      mantap+=("hore4")
fi
if [[ $status05 == "" ]]; then
      sstatus05=$ERROR
      ingfo+=("OHP DROPBEAR")
      dahlah+=("err5")
else
      sstatus05=$AKTIF
      mantap+=("hore5")
fi
if [[ $status06 == "" ]]; then
      sstatus06=$ERROR
      ingfo+=("OHP OVPN")
      dahlah+=("err6")
else
      sstatus06=$AKTIF
      mantap+=("hore6")
fi
if [[ $status07 == "" ]]; then
      sstatus07=$ERROR
      ingfo+=("OHP SSH")
      dahlah+=("err7")
else
      sstatus07=$AKTIF
      mantap+=("hore7")
fi
if [[ $status08 == "" ]]; then
      sstatus08=$ERROR
      ingfo+=("IPSEC SERVICE")
      dahlah+=("err8")
else
      sstatus08=$AKTIF
      mantap+=("hore8")
fi
if [[ $status09 == "" ]]; then
      sstatus09=$ERROR
      ingfo+=("SSTP")
      dahlah+=("err9")
else
      sstatus09=$AKTIF
      mantap+=("hore9")
fi
if [[ $status10 == "" ]]; then
      sstatus10=$ERROR
      ingfo+=("PPTP")
      dahlah+=("err10")
else
      sstatus10=$AKTIF
      mantap+=("hore10")
fi
if [[ $status11 == "" ]]; then
      sstatus11=$ERROR
      ingfo+=("L2TP")
      dahlah+=("err11")
else
      sstatus11=$AKTIF
      mantap+=("hore11")
fi
if [[ $status12 == "" ]]; then
      sstatus12=$ERROR
      ingfo+=("NGINX")
      dahlah+=("err12")
else
      sstatus12=$AKTIF
      mantap+=("hore12")
fi
if [[ $status13 == "" ]]; then
      sstatus13=$ERROR
      ingfo+=("SQUID")
      dahlah+=("err13")
else
      sstatus13=$AKTIF
      mantap+=("hore13")
fi
if [[ $status14 == "" ]]; then
      sstatus14=$ERROR
      ingfo+=("CRON SERVICE")
      dahlah+=("err14")
else
      sstatus14=$AKTIF
      mantap+=("hore14")
fi
if [[ $status15 == "" ]]; then
      sstatus15=$ERROR
      ingfo+=("FAIL2BAN SERVICE")
      dahlah+=("err15")
else
      sstatus15=$AKTIF
      mantap+=("hore15")
fi
if [[ $status16 == "" ]]; then
      sstatus16=$ERROR
      ingfo+=("VNSTATS SERVICE")
      dahlah+=("err16")
else
      sstatus16=$AKTIF
      mantap+=("hore16")
fi
if [[ $status17 == "" ]]; then
      sstatus17=$ERROR
      ingfo+=("SSLH SERVICE")
      dahlah+=("err17")
else
      sstatus17=$AKTIF
      mantap+=("hore17")
fi
if [[ $status18 == "" ]]; then
      sstatus18=$ERROR
      ingfo+=("Privoxy")
      dahlah+=("err18")
else
      sstatus18=$AKTIF
      mantap+=("hore18")
fi
if [[ $status19 == "" ]]; then
      sstatus19=$ERROR
      ingfo+=("WEBSOCKET TLS")
      dahlah+=("err19")
else
      sstatus19=$AKTIF
      mantap+=("hore19")
fi
if [[ $status19 == "" ]]; then
      sstatus19=$ERROR
      ingfo+=("WEBSOCKET NON TLS")
      dahlah+=("err20")
else
      sstatus19=$AKTIF
      mantap+=("hore20")
fi
if [[ $status20 == "" ]]; then
      sstatus20=$ERROR
      ingfo+=("WEBSOCKET OVPN")
      dahlah+=("err21")
else
      sstatus20=$AKTIF
      mantap+=("hore21")
fi
if [[ $status21 == "" ]]; then
      sstatus21=$ERROR
      ingfo+=("WEBSOCKET WIREGUARD")
      dahlah+=("err22")
else
      sstatus21=$AKTIF
      mantap+=("hore22")
fi
if [[ $status22 == "" ]]; then
      sstatus22=$ERROR
      ingfo+=("WIREGUARD")
      dahlah+=("err23")
else
      sstatus22=$AKTIF
      mantap+=("hore23")
fi
if [[ $status23 == "" ]]; then
      sstatus23=$ERROR
      ingfo+=("SHADOWSOCKS OBFS")
      dahlah+=("err24")
else
      sstatus23=$AKTIF
      mantap+=("hore24")
fi
if [[ $status23 == "" ]]; then
      sstatus23=$ERROR
      ingfo+=("SHADOWSOCKS HTTP")
      dahlah+=("err25")
else
      sstatus23=$AKTIF
      mantap+=("hore25")
fi
if [[ $status24 == "" ]]; then
      sstatus24=$ERROR
      ingfo+=("SHADOWSOCKSR")
      dahlah+=("err26")
else
      sstatus24=$AKTIF
      mantap+=("hore26")
fi
if [[ $status25 == "" ]]; then
      sstatus25=$ERROR
      ingfo+=("VMESS WS TLS")
      dahlah+=("err27")
else
      sstatus25=$AKTIF
      mantap+=("hore27")
fi
if [[ $status26 == "" ]]; then
      sstatus26=$ERROR
      ingfo+=("VMESS WS NON TLS")
      dahlah+=("err28")
else
      sstatus26=$AKTIF
      mantap+=("hore28")
fi
if [[ $status27 == "" ]]; then
      sstatus27=$ERROR
      ingfo+=("VMESS GRPC TLS")
      dahlah+=("err29")
else
      sstatus27=$AKTIF
      mantap+=("hore29")
fi
if [[ $status28 == "" ]]; then
      sstatus28=$ERROR
      ingfo+=("VMESS GRPC NON TLS")
      dahlah+=("err30")
else
      sstatus28=$AKTIF
      mantap+=("hore30")
fi
if [[ $status29 == "" ]]; then
      sstatus29=$ERROR
      ingfo+=("VMESS HTTP TLS")
      dahlah+=("err31")
else
      sstatus29=$AKTIF
      mantap+=("hore31")
fi
if [[ $status30 == "" ]]; then
      sstatus30=$ERROR
      ingfo+=("VMESS HTTP NON TLS")
      dahlah+=("err32")
else
      sstatus30=$AKTIF
      mantap+=("hore32")
fi
if [[ $status31 == "" ]]; then
      sstatus31=$ERROR
      ingfo+=("VMESS H2C TLS")
      dahlah+=("err33")
else
      sstatus31=$AKTIF
      mantap+=("hore33")
fi
if [[ $status32 == "" ]]; then
      sstatus32=$ERROR
      ingfo+=("VLESS WS TLS")
      dahlah+=("err34")
else
      sstatus32=$AKTIF
      mantap+=("hore34")
fi
if [[ $status33 == "" ]]; then
      sstatus33=$ERROR
      ingfo+=("VLESS WS NON TLS")
      dahlah+=("err35")
else
      sstatus33=$AKTIF
      mantap+=("hore35")
fi
if [[ $status34 == "" ]]; then
      sstatus34=$ERROR
      ingfo+=("VLESS GRPC TLS")
      dahlah+=("err36")
else
      sstatus34=$AKTIF
      mantap+=("hore36")
fi
if [[ $status35 == "" ]]; then
      sstatus35=$ERROR
      ingfo+=("VLESS GRPC NON TLS")
      dahlah+=("err37")
else
      sstatus35=$AKTIF
      mantap+=("hore37")
fi
if [[ $status36 == "" ]]; then
      sstatus36=$ERROR
      ingfo+=("VLESS XTLS")
      dahlah+=("err38")
else
      sstatus36=$AKTIF
      mantap+=("hore38")
fi
if [[ $status37 == "" ]]; then
      sstatus37=$ERROR
      ingfo+=("VLESS HTTP TLS")
      dahlah+=("err39")
else
      sstatus37=$AKTIF
      mantap+=("hore39")
fi
if [[ $status38 == "" ]]; then
      sstatus38=$ERROR
      ingfo+=("VLESS HTTP NON TLS")
      dahlah+=("err40")
else
      sstatus38=$AKTIF
      mantap+=("hore40")
fi
if [[ $status39 == "" ]]; then
      sstatus39=$ERROR
      ingfo+=("VLESS H2C TLS")
      dahlah+=("err41")
else
      sstatus39=$AKTIF
      mantap+=("hore41")
fi
if [[ $status40 == "" ]]; then
      sstatus40=$ERROR
      ingfo+=("TROJAN XTLS")
      dahlah+=("err42")
else
      sstatus40=$AKTIF
      mantap+=("hore42")
fi
if [[ $status41 == "" ]]; then
      sstatus41=$ERROR
      ingfo+=("TROJAN GO")
      dahlah+=("err43")
else
      sstatus41=$AKTIF
      mantap+=("hore43")
fi
if [[ $status42 == "" ]]; then
      sstatus42=$ERROR
      ingfo+=("TROJAN HTTP")
      dahlah+=("err44")
else
      sstatus42=$AKTIF
      mantap+=("hore44")
fi
if [[ $status43 == "" ]]; then
      sstatus43=$ERROR
      ingfo+=("TROJAN H2C")
      dahlah+=("err45")
else
      sstatus43=$AKTIF
      mantap+=("hore45")
fi
if [[ $status44 == "" ]]; then
      sstatus44=$ERROR
      ingfo+=("TROJAN GRPC")
      dahlah+=("err46")
else
      sstatus44=$AKTIF
      mantap+=("hore46")
fi
if [[ $status45 == "" ]]; then
      sstatus45=$ERROR
      ingfo+=("TROJAN WS TLS")
      dahlah+=("err47")
else
      sstatus45=$AKTIF
      mantap+=("hore47")
fi
if [[ $status46 == "" ]]; then
      sstatus46=$ERROR
      ingfo+=("TROJAN WS NON TLS")
      dahlah+=("err48")
else
      sstatus46=$AKTIF
      mantap+=("hore48")
fi
if [[ $status47 == "" ]]; then
      sstatus47=$ERROR
      ingfo+=("XRAY SHADOWSOCKS")
      dahlah+=("err49")
else
      sstatus47=$AKTIF
      mantap+=("hore49")
fi
if [[ $status48 == "" ]]; then
      sstatus48=$ERROR
      ingfo+=("XRAY MT PROTO")
      dahlah+=("err50")
else
      sstatus48=$AKTIF
      mantap+=("hore50")
fi
if [[ $status49 == "" ]]; then
      sstatus49=$ERROR
      ingfo+=("SOCKS5 WEBSOCKET")
      dahlah+=("err51")
else
      sstatus49=$AKTIF
      mantap+=("hore51")
fi
if [[ $status50 == "" ]]; then
      sstatus50=$ERROR
      ingfo+=("VMESS H2C NON TLS")
      dahlah+=("err52")
else
      sstatus50=$AKTIF
      mantap+=("hore52")
fi
if [[ $status51 == "" ]]; then
      sstatus51=$ERROR
      ingfo+=("VLESS H2C NON TLS")
      dahlah+=("err53")
else
      sstatus51=$AKTIF
      mantap+=("hore53")
fi
if [[ $status52 == "" ]]; then
      sstatus52=$ERROR
      ingfo+=("XRAY SOCKS5 TCP")
      dahlah+=("err54")
else
      sstatus52=$AKTIF
      mantap+=("hore54")
fi
jumlah1="${#mantap[@]}"
jumlah2="${#dahlah[@]}"

if [[ $jumlah1 == "" ]] || [[ $jumlah1 -eq 0 ]]; then
     jumlah_aktif=0
else
     let njor=${jumlah1}
     jumlah_aktif=$njor
fi

if [[ $jumlah2 == "" ]] || [[ $jumlah2 -eq 0 ]]; then
    jumlah_error=0
else
    let njir=${jumlah2}
    jumlah_error=$njir
fi

#=================================================================================================
clear
# VPS Information
Checkstart1=$(ip route | grep default | cut -d ' ' -f 3 | head -n 1);
if [[ $Checkstart1 == "venet0" ]]; then 
    # Getting

clear
	  lan_net="venet0"
    typevps="OpenVZ"
    sleep 1
else
    clear
		lan_net="eth0"
    typevps="KVM"
    sleep 1
fi

# GETTING OS INFORMATION
source /etc/os-release
Versi_OS=$VERSION
ver=$VERSION_ID
Tipe=$NAME
URL_SUPPORT=$HOME_URL
basedong=$ID

# VPS ISP INFORMATION
ITAM='\033[0;30m'
echo -e "$ITAM"
NAMAISP=$( curl -s ipinfo.io/org | cut -d " " -f 2-10  )
REGION=$( curl -s ipinfo.io/region )
#clear
COUNTRY=$( curl -s ipinfo.io/country )
#clear
WAKTU=$( curl -s ipinfo.ip/timezone )
#clear
CITY=$( curl -s ipinfo.io/city )
#clear
REGION=$( curl -s ipinfo.io/region )
#clear
WAKTUE=$( curl -s ipinfo.io/timezone )
#clear
koordinat=$( curl -s ipinfo.io/loc )
#clear
NC='\033[0m'
echo -e "$NC"

# RAM USAGE
total_r2am=` grep "MemAvailable: " /proc/meminfo | awk '{ print $2}'`
MEMORY=$(($total_r2am/1024))

# DOWNLOAD
download=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev  | awk '{print $2}' | paste -sd+ - | bc`
downloadsize=$(($download/1073741824))

# UPLOAD
upload=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev | awk '{print $10}' | paste -sd+ - | bc`
uploadsize=$(($upload/1073741824))

# TOTAL RAM
total_ram=` grep "MemTotal: " /proc/meminfo | awk '{ print $2}'`
totalram=$(($total_ram/1024))

# TIPE PROCESSOR
totalcore="$(grep -c "^processor" /proc/cpuinfo)" 
totalcore+=" Core"
corediilik="$(grep -c "^processor" /proc/cpuinfo)" 
tipeprosesor="$(awk -F ': | @' '/model name|Processor|^cpu model|chip type|^cpu type/ {
                        printf $2;
                        exit
                        }' /proc/cpuinfo)"

# SHELL VERSION
shellversion=""
shellversion=Bash
shellversion+=" Version" 
shellversion+=" ${BASH_VERSION/-*}" 
versibash=$shellversion

# GETTING CPU INFORMATION
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"

# OS UPTIME
uptime="$(uptime -p | cut -d " " -f 2-10)"

# KERNEL TERBARU
kernelku=$(uname -r)

# WAKTU SEKARANG 
harini=`date -d "0 days" +"%d-%m-%Y"`
jam=`date -d "0 days" +"%X"`

# DNS PATCH
tipeos2=$(uname -m)

# GETTING DOMAIN NAME
Domen="$(cat /etc/xray/domain)"
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	tram=$( free -m | awk 'NR==2 {print $2}' )
	swap=$( free -m | awk 'NR==4 {print $2}' )
	up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')

# ECHOING RESULT
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[43;1;46m            🔰 SPESIFIKASI LINUX SERVER 🔰              \E[0m"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "LINUX : $typevps $Tipe $VERSION"                                                                                                                                                                                              
echo -e "KERNEL: $kernelku"
echo -e "CORE  : $totalcore @$freq MHz CPU TERPAKAI $cpu_usage"                                                                                                                                                                                
echo -e "CPU   : $tipeprosesor"
echo -e "RAM   : ${totalram}MB  SISA RAM : ${MEMORY}MB"                                                                                                                                                                                   
echo -e "ONLINE: $(uptime -p | cut -d " " -f 2-10)"                                                                                                                                                                       
echo -e "HOST  : $HOSTNAME $Domen"
echo -e "ISP   : $NAMAISP $REGION"                                                                                                                                                                                                                                                                                                                                      
echo -e "WAKTU : $jam wib $harini"                                                                                                                                                                                                                                
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[43;1;46m              🔰 STATUS LAYANAN SERVER 🔰               \E[0m"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$bl🔰 $off $bl DROPBEAR                    $off : $sstatus01🔰"
echo -e "$bl🔰 $off $bl OPENSSH                     $off : $sstatus02🔰"
echo -e "$bl🔰 $off $bl STUNNEL5                    $off : $sstatus03🔰"
echo -e "$bl🔰 $off $bl OPENVPN                     $off : $sstatus04🔰"
echo -e "$bl🔰 $off $bl OHP DROPBEAR                $off : $sstatus05🔰"
echo -e "$bl🔰 $off $bl OHP OVPN                    $off : $sstatus06🔰"
echo -e "$bl🔰 $off $bl OHP SSH                     $off : $sstatus07🔰"
echo -e "$bl🔰 $off $bl IPSEC                       $off : $sstatus08🔰"
echo -e "$bl🔰 $off $bl SSTP                        $off : $sstatus09🔰"
echo -e "$bl🔰 $off $bl PPTP                        $off : $sstatus10🔰"
echo -e "$bl🔰 $off $bl L2TP                        $off : $sstatus11🔰"
echo -e "$bl🔰 $off $bl NGINX                       $off : $sstatus12🔰"
echo -e "$bl🔰 $off $bl SQUID                       $off : $sstatus13🔰"
echo -e "$bl🔰 $off $bl CRON SERVICE                $off : $sstatus14🔰"
echo -e "$bl🔰 $off $bl FAIL2BAN SERVICE            $off : $sstatus15🔰"
echo -e "$bl🔰 $off $bl VNSTAT SERVICE              $off : $sstatus16🔰"
echo -e "$bl🔰 $off $bl SSLH SERVICE                $off : $sstatus17🔰"
echo -e "$bl🔰 $off $bl PRIVOXY                     $off : $sstatus18🔰"
echo -e "$bl🔰 $off $bl WEBSOCKET TLS               $off : $sstatus19🔰"
echo -e "$bl🔰 $off $bl WEBSOCKET NON TLS           $off : $sstatus19🔰"
echo -e "$bl🔰 $off $bl WEBSOCKET OpenVPN           $off : $sstatus20🔰"
echo -e "$bl🔰 $off $bl WEBSOCKET wireguard         $off : $sstatus21🔰"
echo -e "$bl🔰 $off $bl WIREGUARD                   $off : $sstatus22🔰"
echo -e "$bl🔰 $off $bl SHADOWSOCKS OBFS            $off : $sstatus23🔰"
echo -e "$bl🔰 $off $bl SHADOWSOCKS HTTP            $off : $sstatus23🔰"
echo -e "$bl🔰 $off $bl SHADOWSOCKSR                $off : $sstatus24🔰"
echo -e "$bl🔰 $off $bl VMESS WS TLS                $off : $sstatus25🔰"
echo -e "$bl🔰 $off $bl VMESS WS NON TLS            $off : $sstatus26🔰"
echo -e "$bl🔰 $off $bl VMESS GRPC TLS              $off : $sstatus27🔰"
echo -e "$bl🔰 $off $bl VMESS GRPC NON TLS          $off : $sstatus28🔰"
echo -e "$bl🔰 $off $bl VMESS HTTP TLS              $off : $sstatus29🔰"
echo -e "$bl🔰 $off $bl VMESS HTTP NON TLS          $off : $sstatus30🔰"
echo -e "$bl🔰 $off $bl VMESS H2C TLS               $off : $sstatus31🔰"
echo -e "$bl🔰 $off $bl VMESS H2C NON TLS           $off : $sstatus50🔰"
echo -e "$bl🔰 $off $bl VLESS WS TLS                $off : $sstatus32🔰"
echo -e "$bl🔰 $off $bl VLESS WS NON TLS            $off : $sstatus33🔰"
echo -e "$bl🔰 $off $bl VLESS GRPC TLS              $off : $sstatus34🔰"
echo -e "$bl🔰 $off $bl VLESS GRPC NON TLS          $off : $sstatus35🔰"
echo -e "$bl🔰 $off $bl VLESS XTLS                  $off : $sstatus36🔰"
echo -e "$bl🔰 $off $bl VLESS HTTP TLS              $off : $sstatus37🔰"
echo -e "$bl🔰 $off $bl VLESS HTTP NON TLS          $off : $sstatus38🔰"
echo -e "$bl🔰 $off $bl VLESS H2C TLS               $off : $sstatus39🔰"
echo -e "$bl🔰 $off $bl VLESS H2C NON TLS           $off : $sstatus51🔰"
echo -e "$bl🔰 $off $bl TROJAN XTLS                 $off : $sstatus40🔰"
echo -e "$bl🔰 $off $bl TROJAN GO                   $off : $sstatus41🔰"
echo -e "$bl🔰 $off $bl TROJAN HTTP                 $off : $sstatus42🔰"
echo -e "$bl🔰 $off $bl TROJAN H2C                  $off : $sstatus43🔰"
echo -e "$bl🔰 $off $bl TROJAN GRPC                 $off : $sstatus44🔰"
echo -e "$bl🔰 $off $bl TROJAN WS TLS               $off : $sstatus45🔰"
echo -e "$bl🔰 $off $bl TROJAN WS NON TLS           $off : $sstatus46🔰"
echo -e "$bl🔰 $off $bl XRAY SHADOWSOCKS            $off : $sstatus47🔰"
echo -e "$bl🔰 $off $bl XRAY MT PROTO               $off : $sstatus48🔰"
echo -e "$bl🔰 $off $bl SOCKS5 WEBSOCKET            $off : $sstatus49🔰"
echo -e "$bl🔰 $off $bl SOCKS5 TCP                  $off : $sstatus52🔰"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[43;1;46m             🔰 SOLO THE SPIRIT OF JAVA 🔰              \E[0m"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "  🔰 JUMLAH LAYANAN RUNNING PERFECT [ ${green}$jumlah_aktif${off} ]"
echo -e "  ⚠️ JUMLAH LAYANAN RUNNING TROUBLE [ ${red}$jumlah_error${off} ]"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[43;1;46m             🔰 LUXURY EDITION ZEROSSL 🔰               \E[0m"
echo -e "\033[1;31m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
