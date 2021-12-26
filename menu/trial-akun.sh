#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
bl='\e[36;1m'
bd='\e[1m'
color1='\e[031;1m'
color2='\e[34;1m'
color3='\e[0m'
MYIP=$(wget -qO- ifconfig.co);
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/Sangarya/izin/main/ipvps | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo "Only For Premium Users"
exit 0
fi
clear
cat /usr/bin/bannerSSH | lolcat
echo -e""
echo -e "${color1} 1${color3}.$bd Trial Account V2ray Vmess (${color2}trial-ws${color3})"
echo -e "${color1} 2${color3}.$bd Trial Account V2ray Vless (${color2}trial-vless${color3})"
echo -e "${color1} 3${color3}.$bd Trial Account Trojan (${color2}trial-tr${color3})"
echo -e "${color1} 4${color3}.$bd Trial Account Secure Socket Tunneling Protocol (${color2}trial-sstp${color3})"
echo -e "${color1} 5${color3}.$bd Trial Account Point-to-Point Tunneling Protocol (${color2}trial-pptp${color3})"
echo -e "${color1} 6${color3}.$bd Trial Account ShadowsocksR (${color2}trial-ssr${color3})"
echo -e "${color1} 7${color3}.$bd Trial Account Shadowsocks (${color2}trial-ss${color3})"
echo -e "${color1} 8${color3}.$bd Trial Account Layer Two Tunneling Protocol (${color2}trial-l2tp${color3})"
echo -e "${color1} 9${color3}.$bd Trial Account SSH & OpenVPN (${color2}trial${color3})"
echo -e "${color1}10${color3}.$bd Trial Account Trojan-GO (${color2}trial-trgo${color3})"
echo -e "${color1}11${color3}.$bd Trial Account WireGuard® Protokol (${color2}trial-wg${color3})"
echo -e""
echo -e "${color1}x${color3}.$bd Menu"
echo -e""
read -p "  Please Enter The Number  [1-11 or x] :  "  triall
echo -e ""
case $triall in
1)
trial-ws
;;
2)
trial-vless
;;
3)
trial-tr
;;
4)
trial-sstp
;;
5)
trial-pptp
;;
6)
trial-ssr
;;
7)
trial-ss
;;
8)
trial-l2tp
;;
9)
trial
;;
10)
trial-trgo
;;
11)
trial-wg
;;
x)
menu
;;
*)
echo "Masukkan Nomor Yang Ada Sayang!"
trial-akun
;;
esac
