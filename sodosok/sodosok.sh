#!/bin/bash
#shadowsocks-libev obfs install by MUHAMMAD AMIN
source /etc/os-release
OS=$ID
ver=$VERSION_ID

#Install_Packages
echo "#############################################"
echo "Install Paket..."
apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake -y
echo "Install Paket Selesai."
echo "#############################################"


#Install_Shadowsocks_libev
echo "#############################################"
echo "Install Shadowsocks-libev..."
apt-get install software-properties-common -y
if [[ $OS == 'ubuntu' ]]; then
apt install shadowsocks-libev -y
apt install simple-obfs -y
elif [[ $OS == 'debian' ]]; then
if [[ "$ver" = "9" ]]; then
echo "deb http://deb.debian.org/debian stretch-backports main" | tee /etc/apt/sources.list.d/stretch-backports.list
apt update
apt -t stretch-backports install shadowsocks-libev -y
apt -t stretch-backports install simple-obfs -y
elif [[ "$ver" = "10" ]]; then
echo "deb http://deb.debian.org/debian buster-backports main" | tee /etc/apt/sources.list.d/buster-backports.list
apt update
apt -t buster-backports install shadowsocks-libev -y
apt -t buster-backports install simple-obfs -y
fi
fi
echo "Install Shadowsocks-libev Selesai."
echo "#############################################"

#Server konfigurasi
echo "#############################################"
echo "Konfigurasi Server."
cat > /etc/shadowsocks-libev/config.json <<END
{   
    "server":"0.0.0.0",
    "server_port":8488,
    "password":"tes",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
}
END
echo "#############################################"

#mulai ~shadowsocks-libev~ server
echo "#############################################"
echo "mulai ss server"
systemctl enable shadowsocks-libev.service
systemctl start shadowsocks-libev.service
echo "#############################################"

#buat client config
echo "#############################################"
echo "buat config obfs"
cat > /etc/shadowsocks-libev.json <<END
{
    "server":"127.0.0.1",
    "server_port":8388,
    "local_port":1080,
    "password":"",
    "timeout":60,
    "method":"chacha20-ietf-poly1305",
    "mode":"tcp_and_udp",
    "fast_open":true,
    "plugin":"/usr/bin/obfs-local",
    "plugin_opts":"obfs=tls;failover=127.0.0.1:1443;fast-open"
}
END
chmod +x /etc/shadowsocks-libev.json
echo "#############################################"
#Server konfigurasi
echo "#############################################"
echo "Konfigurasi Server."
cat > /etc/shadowsocks-libev/tls.json <<END
{   
    "server":"0.0.0.0",
    "server_port":2445,
    "password":"ss",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "no_delay":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=tls"
}
END
echo "#############################################"

#mulai ~shadowsocks-libev~ server
echo "#############################################"
echo "mulai ss server"
systemctl enable shadowsocks-libev-server@tls
systemctl restart shadowsocks-libev-server@tls
echo "#############################################"

#buat client config
echo "#############################################"
echo "buat config obfs"
cat > /etc/shadowsocks-libev/http.json <<END
{
    "server":"0.0.0.0",
    "server_port":3445,
    "password":"ss",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "no_delay":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=http"
}
END
systemctl enable shadowsocks-libev-server@http
systemctl restart shadowsocks-libev-server@http
chmod +x /etc/shadowsocks-libev/tls.json
chmod +x /etc/shadowsocks-libev/http.json
echo "#############################################"
echo -e "">>"/etc/shadowsocks-libev/akun.conf"

echo "#############################################"
echo "Menambahkan Perintah Shadowsocks-libev"
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2443:3543 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2443:3543 -j ACCEPT
iptables-save > /etc/iptables.up.rules
ip6tables-save > /etc/ip6tables.up.rules
cd /usr/bin
wget -O add-ss "https://raw.githubusercontent.com/Sangarya/premium/main/add/add-ss.sh"
wget -O del-ss "https://raw.githubusercontent.com/Sangarya/premium/main/del/del-ss.sh"
wget -O cek-ss "https://raw.githubusercontent.com/Sangarya/premium/main/cek/cek-ss.sh"
wget -O renew-ss "https://raw.githubusercontent.com/Sangarya/premium/main/renew/renew-ss.sh"
wget -O /usr/bin/system https://raw.githubusercontent.com/Sangarya/premium/main/menu/system.sh && chmod +x /usr/bin/system
wget -O /usr/bin/host https://raw.githubusercontent.com/Sangarya/premium/main/v2ray/host.sh && chmod +x /usr/bin/host
wget -O /usr/bin/clear-log https://raw.githubusercontent.com/Sangarya/premium/main/file/clear-log.sh && chmod +x /usr/bin/clear-log
wget -O /usr/bin/pointing https://raw.githubusercontent.com/Sangarya/premium/main/file/pointing.sh && chmod +x /usr/bin/pointing
wget -O /usr/bin/bw https://raw.githubusercontent.com/Sangarya/premium/main/file/bw.sh && chmod +x /usr/bin/bw
wget https://raw.githubusercontent.com/Sangarya/premium/main/file/antiabuse.sh && chmod +x antiabuse.sh && ./antiabuse.sh
wget https://raw.githubusercontent.com/Sangarya/premium/main/ohp/ohp.sh && chmod +x ohp.sh
wget -O /usr/bin/renew-trgo raw.githubusercontent.com/Sangarya/premium/main/trojan-go/renew-trgo.sh && chmod +x /usr/bin/renew-trgo
wget -O /usr/bin/del-trgo raw.githubusercontent.com/Sangarya/premium/main/trojan-go/del-trgo.sh && chmod +x /usr/bin/del-trgo
wget -O /usr/bin/cek-trgo raw.githubusercontent.com/Sangarya/premium/main/trojan-go/cek-trgo.sh && chmod +x /usr/bin/cek-trgo
wget -O /usr/bin/add-trgo raw.githubusercontent.com/Sangarya/premium/main/trojan-go/add-trgo.sh && chmod +x /usr/bin/add-trgo
wget -O /usr/bin/port-trgo raw.githubusercontent.com/Sangarya/premium/main/trojan-go/port-trgo.sh && chmod +x /usr/bin/port-trgo 
wget -O /usr/bin/bannerBACKUP https://raw.githubusercontent.com/Sangarya/premium/main/menu/banner/bannerBACKUP && chmod +x /usr/bin/bannerBACKUP
wget -O /usr/bin/bannerL2TP https://raw.githubusercontent.com/Sangarya/premium/main/menu/banner/bannerL2TP && chmod +x /usr/bin/bannerL2TP
wget -O /usr/bin/bannerPPTP https://raw.githubusercontent.com/Sangarya/premium/main/menu/banner/bannerPPTP && chmod +x /usr/bin/bannerPPTP
wget -O /usr/bin/bannerSHADOWSOCK https://raw.githubusercontent.com/Sangarya/premium/main/menu/banner/bannerSHADOWSOCK && chmod +x /usr/bin/bannerSHADOWSOCK
wget -O /usr/bin/bannerSSH https://raw.githubusercontent.com/Sangarya/premium/main/menu/banner/bannerSSH && chmod +x /usr/bin/bannerSSH
wget -O /usr/bin/bannerSSTP https://raw.githubusercontent.com/Sangarya/premium/main/menu/banner/bannerSSTP && chmod +x /usr/bin/bannerSSTP
wget -O /usr/bin/bannerTROJAN https://raw.githubusercontent.com/Sangarya/premium/main/menu/banner/bannerTROJAN && chmod +x /usr/bin/bannerTROJAN
wget -O /usr/bin/bannerV2RAY https://raw.githubusercontent.com/Sangarya/premium/main/menu/banner/bannerV2RAY && chmod +x /usr/bin/bannerV2RAY
wget -O /usr/bin/bannerDOMAIN https://raw.githubusercontent.com/Sangarya/premium/main/menu/banner/bannerDOMAIN && chmod +x /usr/bin/bannerDOMAIN
wget -O /usr/bin/bannerSYSTEM https://raw.githubusercontent.com/Sangarya/premium/main/menu/banner/bannerSYSTEM && chmod +x /usr/bin/bannerSYSTEM
wget -O /usr/bin/panelVPN https://raw.githubusercontent.com/Sangarya/premium/main/menu/banner/panelVPN && chmod +x /usr/bin/panelVPN
wget -O /usr/bin/bebek https://raw.githubusercontent.com/Sangarya/premium/main/menu/bebek.sh && chmod +x /usr/bin/bebek
wget -O /usr/bin/l2tp https://raw.githubusercontent.com/Sangarya/premium/main/menu/l2tp.sh && chmod +x /usr/bin/l2tp
wget -O /usr/bin/bannerWIREGUARD https://raw.githubusercontent.com/Sangarya/premium/main/menu/banner/bannerWIREGUARD && chmod +x /usr/bin/bannerWIREGUARD
wget -O /usr/bin/paneli https://raw.githubusercontent.com/Sangarya/premium/main/menu/paneli.sh && chmod +x /usr/bin/paneli
wget -O /usr/bin/ppt https://raw.githubusercontent.com/Sangarya/premium/main/menu/ppt.sh && chmod +x /usr/bin/ppt
wget -O /usr/bin/ssh https://raw.githubusercontent.com/Sangarya/premium/main/menu/ssh.sh && chmod +x /usr/bin/ssh
wget -O /usr/bin/ssssr https://raw.githubusercontent.com/Sangarya/premium/main/menu/ssssr.sh && chmod +x /usr/bin/ssssr
wget -O /usr/bin/sstpp https://raw.githubusercontent.com/Sangarya/premium/main/menu/sstpp.sh && chmod +x /usr/bin/sstpp
wget -O /usr/bin/trojaan https://raw.githubusercontent.com/Sangarya/premium/main/menu/trojaan.sh && chmod +x /usr/bin/trojaan
wget -O /usr/bin/v2raay https://raw.githubusercontent.com/Sangarya/premium/main/menu/v2raay.sh && chmod +x /usr/bin/v2raay
wget -O /usr/bin/vleess https://raw.githubusercontent.com/Sangarya/premium/main/menu/vleess.sh && chmod +x /usr/bin/vleess
wget -O /usr/bin/wgr https://raw.githubusercontent.com/Sangarya/premium/main/menu/wgr.sh && chmod +x /usr/bin/wgr
wget -O /usr/bin/user-generate https://raw.githubusercontent.com/Sangarya/premium/main/file/user-generate && chmod +x /usr/bin/user-generate
wget -O /usr/bin/autoreboot https://raw.githubusercontent.com/Sangarya/premium/main/file/autoreboot.sh && chmod +x /usr/bin/autoreboot
wget -O /usr/bin/add-l2tp https://raw.githubusercontent.com/Sangarya/premium/main/add/add-l2tp.sh && chmod +x /usr/bin/add-l2tp && cd /usr/bin && apt install -y dos2unix && dos2unix add-l2tp
wget -O /home/vps/public_html/index.html https://raw.githubusercontent.com/Sangarya/premium/main/setup/index.html && chmod +x /home/vps/public_html/index.html && cd /home/vps/public_html/index.html && apt install -y dos2unix && dos2unix index.html
#l2tp
figlet -f slant L2TP | lolcat
cd /usr/bin
wget -O /usr/bin/add-cf https://raw.githubusercontent.com/Sangarya/premium/main/v2ray/add-cf.sh && chmod +x /usr/bin/add-cf
wget -O /usr/bin/add-l2tp https://raw.githubusercontent.com/Sangarya/premium/main/add/add-l2tp.sh && chmod +x /usr/bin/add-l2tp
wget -O /usr/bin/del-l2tp https://raw.githubusercontent.com/Sangarya/premium/main/del/del-l2tp.sh && chmod +x /usr/bin/del-l2tp
wget -O /usr/bin/add-pptp https://raw.githubusercontent.com/Sangarya/premium/main/add/add-pptp.sh && chmod +x /usr/bin/add-pptp
wget -O /usr/bin/del-pptp https://raw.githubusercontent.com/Sangarya/premium/main/del/del-pptp.sh && chmod +x /usr/bin/del-pptp
wget -O /usr/bin/renew-pptp https://raw.githubusercontent.com/Sangarya/premium/main/renew/renew-pptp.sh && chmod +x /usr/bin/renew-pptp
wget -O /usr/bin/renew-l2tp https://raw.githubusercontent.com/Sangarya/premium/main/renew/renew-l2tp.sh && chmod +x /usr/bin/renew-l2tp
touch /var/lib/premium-script/data-user-l2tp
touch /var/lib/premium-script/data-user-pptp
rm -f /root/ipsec.sh

sleep 1
cd /usr/bin
wget -O /usr/bin/bebek https://raw.githubusercontent.com/Sangarya/premium/main/menu/bebek.sh && chmod +x /usr/bin/bebek
wget -O /usr/bin/ppt https://raw.githubusercontent.com/Sangarya/premium/main/menu/ppt.sh && chmod +x /usr/bin/ppt
wget -O /usr/bin/menu https://raw.githubusercontent.com/Sangarya/premium/main/menu/menu.sh && chmod +x /usr/bin/menu
wget -O /usr/bin/paneli https://raw.githubusercontent.com/Sangarya/premium/main/menu/paneli.sh && chmod +x /usr/bin/paneli
wget -O add-ss "https://raw.githubusercontent.com/Sangarya/premium/main/add/add-ss.sh"
wget -O del-ss "https://raw.githubusercontent.com/Sangarya/premium/main/del/del-ss.sh"
wget -O cek-ss "https://raw.githubusercontent.com/Sangarya/premium/main/cek/cek-ss.sh"
wget -O renew-ss "https://raw.githubusercontent.com/Sangarya/premium/main/renew/renew-ss.sh"
chmod +x add-ss
chmod +x del-ss
chmod +x cek-ss
chmod +x renew-ss

#PANEL-PORT
figlet -f slant port | lolcat
sleep 1
cd /usr/bin
wget -O port-ovpn "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-ovpn.sh"
wget -O port-ssl "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-ssl.sh"
wget -O port-wg "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-wg.sh"
wget -O port-tr "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-tr.sh"
wget -O port-sstp "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-sstp.sh"
wget -O port-squid "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-squid.sh"
wget -O port-ws "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-ws.sh"
wget -O port-vless "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-vless.sh"
chmod +x port-ovpn
chmod +x port-ssl
chmod +x port-wg
chmod +x port-tr
chmod +x port-sstp
chmod +x port-squid
chmod +x port-ws
chmod +x port-vless

#PANEL SSH
figlet -f slant SSH | lolcat
sleep 1
cd /usr/bin
wget -O add-host "https://raw.githubusercontent.com/Sangarya/premium/main/add/add-host.sh"
wget -O about "https://raw.githubusercontent.com/Sangarya/premium/main/file/about.sh"
wget -O menu "https://raw.githubusercontent.com/Sangarya/premium/main/menu/menu.sh"
wget -O usernew "https://raw.githubusercontent.com/Sangarya/premium/main/sshvpn/usernew.sh"
wget -O trial "https://raw.githubusercontent.com/Sangarya/premium/main/sshvpn/trial.sh"
wget -O hapus "https://raw.githubusercontent.com/Sangarya/premium/main/sshvpn/hapus.sh"
wget -O member "https://raw.githubusercontent.com/Sangarya/premium/main/sshvpn/member.sh"
wget -O delete "https://raw.githubusercontent.com/Sangarya/premium/main/del/delete.sh"
wget -O cek "https://raw.githubusercontent.com/Sangarya/premium/main/cek/cek.sh"
wget -O restart "https://raw.githubusercontent.com/Sangarya/premium/main/file/restart.sh"
wget -O speedtest "https://raw.githubusercontent.com/Sangarya/premium/main/sshvpn/speedtest_cli.py"
wget -O info "https://raw.githubusercontent.com/Sangarya/premium/main/file/info.sh"
wget -O ram "https://raw.githubusercontent.com/Sangarya/premium/main/file/ram.sh"
wget -O renew "https://raw.githubusercontent.com/Sangarya/premium/main/renew/renew.sh"
wget -O autokill "https://raw.githubusercontent.com/Sangarya/premium/main/file/autokill.sh"
wget -O ceklim "https://raw.githubusercontent.com/Sangarya/premium/main/sshvpn/ceklim.sh"
wget -O tendang "https://raw.githubusercontent.com/Sangarya/premium/main/sshvpn/tendang.sh"
wget -O clear-log "https://raw.githubusercontent.com/Sangarya/premium/main/file/clear-log.sh"
wget -O change-port "https://raw.githubusercontent.com/Sangarya/premium/main/file/change.sh"
wget -O port-ovpn "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-ovpn.sh"
wget -O port-ssl "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-ssl.sh"
wget -O port-wg "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-wg.sh"
wget -O port-tr "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-tr.sh"
wget -O port-sstp "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-sstp.sh"
wget -O port-squid "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-squid.sh"
wget -O port-ws "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-ws.sh"
wget -O port-vless "https://raw.githubusercontent.com/Sangarya/premium/main/port/port-vless.sh"
wget -O wbmn "https://raw.githubusercontent.com/Sangarya/premium/main/file/webmin.sh"
wget -O clear-log "https://raw.githubusercontent.com/Sangarya/premium/main/file/clear-log.sh"
wget -O xp "https://raw.githubusercontent.com/Sangarya/premium/main/file/xp.sh"
wget -O /usr/bin/user-limit https://raw.githubusercontent.com/Sangarya/premium/main/file/user-limit.sh && chmod +x /usr/bin/user-limit
wget -O cfd "https://raw.githubusercontent.com/Sangarya/premium/main/v2ray/cfd.sh"
wget -O cff "https://raw.githubusercontent.com/Sangarya/premium/main/v2ray/cff.sh"
wget -O cfh "https://raw.githubusercontent.com/Sangarya/premium/main/v2ray/cfh.sh"
wget -O trialws "https://raw.githubusercontent.com/Sangarya/premium/main/add/trialws.sh"
wget -O autoreboot "https://raw.githubusercontent.com/Sangarya/premium/main/file/autoreboot.sh"
wget -O bannerku "https://raw.githubusercontent.com/Sangarya/premium/main/menu/bannerku"
wget -O bbr "https://raw.githubusercontent.com/Sangarya/premium/main/menu/bbr.sh"
wget -O menu "https://raw.githubusercontent.com/Sangarya/premium/main/menu/menu.sh"
wget -O trojaan "https://raw.githubusercontent.com/Sangarya/premium/main/menu/trojaan.sh"
wget -O vleess "https://raw.githubusercontent.com/Sangarya/premium/main/menu/vleess.sh"
wget -O wgr "https://raw.githubusercontent.com/Sangarya/premium/main/menu/wgr.sh"
wget -O l2tp "https://raw.githubusercontent.com/Sangarya/premium/main/menu/l2tp.sh"
wget -O v2raay "https://raw.githubusercontent.com/Sangarya/premium/main/menu/v2raay.sh"
wget -O ssh "https://raw.githubusercontent.com/Sangarya/premium/main/menu/ssh.sh"
wget -O sstpp "https://raw.githubusercontent.com/Sangarya/premium/main/menu/sstpp.sh"
wget -O ssssr "https://raw.githubusercontent.com/Sangarya/premium/main/menu/ssssr.sh"
wget -O update "https://raw.githubusercontent.com/Sangarya/premium/main/setup/update.sh"
wget -O running "https://raw.githubusercontent.com/Sangarya/premium/main/menu/running.sh"
wget -O status "https://raw.githubusercontent.com/Sangarya/premium/main/menu/status.sh"
chmod +x add-ss
chmod +x del-ss
chmod +x cek-ss
chmod +x renew-ss
chmod +x trialws
chmod +x add-host
chmod +x menu
chmod +x usernew
chmod +x trial
chmod +x hapus
chmod +x member
chmod +x delete
chmod +x cek
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x autokill
chmod +x tendang
chmod +x ceklim
chmod +x ram
chmod +x renew
chmod +x clear-log
chmod +x change-port
chmod +x port-ovpn
chmod +x port-ssl
chmod +x port-wg
chmod +x port-sstp
chmod +x port-tr
chmod +x port-squid
chmod +x port-ws
chmod +x port-vless
chmod +x wbmn
chmod +x clear-log
chmod +x xp
chmod +x cfd
chmod +x cff
chmod +x cfh
chmod +x autoreboot
chmod +x bannerku
chmod +x bbr
chmod +x menu
chmod +x trojaan
chmod +x vleess
chmod +x wgr
chmod +x l2tp
chmod +x v2raay
chmod +x ssh
chmod +x sstpp
chmod +x ssssr
chmod +x update
chmod +x running
chmod +x status
cd
rm -f /root/sodosok.sh
