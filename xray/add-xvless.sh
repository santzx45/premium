#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ipv4.icanhazip.com);
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/santzx45/izin/main/ipvps | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo "Only For Premium Users"
exit 0
fi
# EDIT IZIN
clear
source /var/lib/premium-script/ipvps.conf
domain=$(cat /etc/v2ray/domain)
tls="$(cat ~/log-install.txt | grep -w "XRAY VLESS TCP" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY VLESS None TCP" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/vlesstls.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/vlesstls.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/vlessnone.json
vtls="vless://${uuid}@${domain}:$tls?path=/xray&security=tls&encryption=none&type=tcp#${user}"
vnone="vless://${uuid}@${domain}:$none?path=/xray&encryption=none&type=tcp#${user}"

systemctl restart xray@vlesstcp
systemctl restart xray@vlessnone
systemctl restart xray@vlesstls

clear
echo -e ""
echo -e "================================="
echo -e "            XRAY VLESS          "
echo -e "================================="
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "port TCP       : $tls"
echo -e "port none TCP  : $none"
echo -e "id             : ${uuid}"
echo -e "Encryption     : none"
echo -e "network        : tcp"
echo -e "path           : /xray"
echo -e "================================="
echo -e "link TLS       : ${vtls}"
echo -e "================================="
echo -e "link TCP       : ${vnone}"
echo -e "================================="
echo -e "================================="
echo -e ""
echo -e "Expired On     : $exp"
