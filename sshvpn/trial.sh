#!/bin/bash
grey='\x1b[90m'
red='\x1b[91m'
green='\x1b[92m'
yellow='\x1b[93m'
blue='\x1b[94m'
purple='\x1b[95m'
cyan='\x1b[96m'
white='\x1b[37m'
bold='\033[1m'
off='\x1b[m'
flag='\x1b[47;41m'

ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
COUNTRY=$(curl -s ipinfo.io/country )

MYIP=$(wget -qO- ipinfo.io/ip);
clear
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
Login=Trial_`</dev/urandom tr -dc X-Z0-9 | head -c2`
hari="1"
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"
Pass=`</dev/urandom tr -dc 0-9 | head -c2`
useradd -e `date -d "1 days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
clear
echo -e ""
echo -e "${yellow}======================${off}"
echo -e "${green} Trial SSH & OpenVPN${off}"
echo -e "${yellow}======================${off}"
echo -e "${green}Username    : $Login "
echo -e "Password    : $Pass"
echo -e "Hostname    : $domain${off}"
echo -e "${yellow}======================${off}"
echo -e "${green}ISP         : $ISP"
echo -e "CITY        : $CITY"
echo -e "COUNTRY     : $COUNTRY"
echo -e "Server IP   : $MYIP"
echo -e "OpenSSH     : 22"
echo -e "Dropbear    : 443, 109, 143"
echo -e "SSL/TLS     :$ssl"
echo -e "WS TLS      : 443, 2096"
echo -e "WS Dropbear : 2052"
echo -e "WS OpenSSH  : 2095"
echo -e "WS OpenVPN  : 2082"
echo -e "Squid       :$sqd"
echo -e "BadVPN      : 7100, 7200, 7300${off}"
echo -e "${yellow}======================${off}"
echo -e "${green} Configs OpenVPN"
echo -e ""
echo -e "TCP $ovpn    : http://$domain:85/tcp.ovpn"
echo -e "UDP $ovpn2    : http://$domain:85/udp.ovpn"
echo -e "SSL 442     : http://$domain:85/ssl.ovpn"
echo -e "Zip File    : http://$domain:85/geo.zip${off}"
echo -e "${yellow}======================${off}"
echo -e ""
echo -e "${green}Payload 1"
echo -e ""
echo -e "GET / HTTP/1.1[crlf]Host: $domain[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]${off}"
echo -e ""
echo -e "${green}Payload 2"
echo -e ""
echo -e "GET wss://BUG [protocol][crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e ""
echo -e "${yellow}======================${off}"
echo -e " ${green}Aktif Selama  : $masaaktif Hari"
echo -e " Dibuat Pada   : $tnggl"
echo -e " Berakhir Pada : $expe${off}"
echo -e "${yellow}======================"
echo -e ""
echo -e " Script Mod Geo Gabot" | lolcat
echo -e ""
