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
MYIP=$(wget -qO- ipv4.icanhazip.com);
echo "Checking VPS"
clear
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
COUNTRY=$(curl -s ipinfo.io/country )
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
Login=Trial`</dev/urandom tr -dc X-Z0-9 | head -c2`
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
echo -e ""
echo -e "Trial : SSH , WebSocket, Openvpn"
echo -e "==============================" | lolcat
echo -e "Username      : $Login "
echo -e "Password      : $Pass"
echo -e "==============================" | lolcat
echo -e "ISP           : $ISP"
echo -e "Host          : $MYIP"
echo -e "Domain        : $domain"
echo -e "OpenSSH       : 171, 22"
echo -e "Dropbear      : 443, 109, 143"
echo -e "SSL/TLS       :$ssl"
echo -e "WS SSL        : 443, 2096"
echo -e "WS OpenSSH    : 2095"
echo -e "WS Dropbear   : 2052"
echo -e "WS Ovpn       : 2082"
echo -e "OHP DropBear  : 8181"
echo -e "OHP OpenVPN   : 8282"
echo -e "OHP OpenSSH   : 8383"
echo -e "Port Squid    :$sqd"
echo -e "Badvpn Udpgw  : 7100-7300"
echo -e "==============================" | lolcat
echo -e "Configs OpenVPN"
echo -e "==============================" | lolcat
echo -e "tcp $ovpn    : http://$domain:85/tcp.ovpn"
echo -e "udp $ovpn2    : http://$domain:85/udp.ovpn"
echo -e "ssl 442     : http://$domain:85/ssl.ovpn"
echo -e "ohp         : http://$domain:85/tcp-ohp.ovpn"
echo -e "zip File    : http://$domain:85/geo.zip${off}"
echo -e "==============================" | lolcat
echo -e "Payload WebSocket 1"
echo -e "==============================" | lolcat
echo -e "GET / HTTP/1.1[crlf]Host: $domain[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "==============================" | lolcat
echo -e "Payload WebSocket 2"
echo -e "==============================" | lolcat
echo -e "GET wss://BUG [protocol][crlf]Host: $domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "==============================" | lolcat
echo -e " ${green}Aktif Selama   : $masaaktif Hari"
echo -e " Dibuat Pada    : $tnggl"
echo -e " Berakhir Pada  : $expe"
echo -e "=============================="
echo -e ""
echo -e " Script Installer By : Geo•NTB"
echo -e ""
echo -e "=============================="
