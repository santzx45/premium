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
uuid=$(cat /etc/trojan/uuid.txt)
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else
domain=$IP
fi
# Create Expried 
tr="$(cat ~/log-install.txt | grep -i Trojan | cut -d: -f2|sed 's/ //g')"
masaaktif="1"
exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

# Make Random Username 
user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
sed -i '/"'""$uuid""'"$/a\,"'""$user""'"' /etc/trojan/config.json
echo -e "### $user $exp" >> /etc/trojan/akun.conf
systemctl restart trojan
trojanlink="trojan://${user}@${domain}:2087"
clear
echo -e ""
echo -e "${red}=================================${off}"
echo -e "${white}       TROJAN ${off}"
echo -e "${red}=================================${off}"
echo -e " ${white}ISP    : ${ISP}"
echo -e " CITY           : ${CITY}"
echo -e " COUNTRY        : ${COUNTRY}"
echo -e " Server IP      : ${MYIP}"
echo -e " Remarks        : ${user}"
echo -e " Host           : ${domain}"
echo -e " Port           : 2087"
echo -e " Key            : geo"
echo -e " Link           : ${trojanlink}${off}"
echo -e "${red}=================================${off}"
echo -e " ${white}Aktif Selama   : $masaaktif Hari"
echo -e "${red}=================================${off}"
