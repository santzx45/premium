#!/bin/bash

#Install SHC
apt-get install build-essential -y
wget -c https://github.com/neurobin/shc/archive/4.0.2.tar.gz
tar xzvf 4.0.2.tar.gz 
cd shc-4.0.2/
./configure 
make
make install


#Masuk Direktori
cd /add

#Encrypt File
shc -r -f add-host
shc -r -f add-l2tp
shc -r -f add-pptp
shc -r -f add-ss
shc -r -f add-ssh
shc -r -f add-ssr
shc -r -f add-sstp
shc -r -f add-tr
shc -r -f add-vless
shc -r -f add-wg
shc -r -f add-ws
shc -r -f autobackup
shc -r -f autokill
shc -r -f backup
shc -r -f cek-pptp
shc -r -f cek-ss
shc -r -f cek-ssh
shc -r -f cek-sstp
shc -r -f cek-tr
shc -r -f cek-vless
shc -r -f cek-wg
shc -r -f cek-ws
shc -r -f cert
shc -r -f change-port
shc -r -f del-l2tp
shc -r -f del-pptp
shc -r -f del-ss
shc -r -f del-ssh
shc -r -f del-ssr
shc -r -f del-sstp
shc -r -f del-tr
shc -r -f del-vless
shc -r -f del-wg
shc -r -f del-ws
shc -r -f delete
shc -r -f info
shc -r -f cek-pptp
shc -r -f cek-ss
shc -r -f cek-sstp
shc -r -f cek-tr
shc -r -f cek-vless
shc -r -f cek-ws
shc -r -f cek
shc -r -f cf
shc -r -f cfd
shc -r -f cff
shc -r -f cfh
shc -r -f port-ovpn
shc -r -f port-squid
shc -r -f port-ssl
shc -r -f port-sstp
shc -r -f port-tr
shc -r -f port-vless
shc -r -f port-wg
shc -r -f port-ws
shc -r -f reboot
shc -r -f renew-l2tp
shc -r -f renew-pptp
shc -r -f renew-ss
shc -r -f renew-ssh
shc -r -f renew-ssr
shc -r -f renew-sstp
shc -r -f renew-tr
shc -r -f renew-vless
shc -r -f renew-wg
shc -r -f renew-ws
shc -r -f restart
shc -r -f restore
shc -r -f strt
shc -r -f swapkvm
shc -r -f tendang
shc -r -f geo
shc -r -f jamal
shc -r -f edu
shc -r -f edu-op.py
shc -r -f proxy-template.py
shc -r -f xp
shc -r -f set-br
shc -r -f trial
shc -r -f usernew
shc -r -f set-br
shc -r -f banner.conf
shc -r -f restart
shc -r -f restore
shc -r -f edu-op.py
shc -r -f ws-udin
shc -r -f menu
shc -r -f paket
shc -r -f bannerku
shc -r -f bannerku1
shc -r -f bannerku
shc -r -f wg


#Move file
mv sodosok.x sodosok
mv ws-udin.x ws-udin
mv edu-op.py.x edu-op.py
mv ssh-vpn.x menu
mv paket.x paket
mv bannerku.x bannerku
mv bannerku.x bannerku
mv wg.x wg
mv cf.x cf
mv setup.x setup
mv wilcard.x wilcard
mv ssh-vpn.x ssh-vpn
mv usernew.x usernew
mv banner.conf.x banner.conf
mv set-br.x set-br
mv cfd.x cfd
mv cff.x cff
mv cfh.x cfh
mv edu-op.py.x edu-op.py
mv proxy-template.py.x proxy-template.py
mv trial.x trial
mv set-br.x set-br
mv add-host.x add-host
mv add-l2tp.x add-l2tp
mv add-pptp.x add-pptp
mv add-ss.x add-ss
mv add-ssh.x add-ssh
mv add-ssr.x add-ssr
mv add-sstp.x add-sstp
mv add-tr.x add-tr
mv add-vless.x add-vless
mv add-wg.x add-wg
mv add-ws.x add-ws
mv autobackup.x autobackup
mv autokill.x autokill
mv backup.x backup
mv cek-pptp.x cek-pptp
mv cek-ss.x cek-ss
mv cek-ssh.x cek-ssh
mv cek-sstp.x cek-sstp
mv cek-tr.x cek-tr
mv cek-vless.x cek-vless
mv cek-wg.x cek-wg
mv cek-ws.x cek-ws
mv cert.x cert
mv change-port.x change-port
mv del-l2tp.x del-l2tp
mv del-pptp.x del-pptp
mv del-ss.x del-ss
mv del-ssh.x del-ssh
mv del-ssr.x del-ssr
mv del-sstp.x del-sstp
mv del-tr.x del-tr
mv del-vless.x del-vless
mv del-wg.x del-wg
mv del-ws.x del-ws
mv delete.x delete
mv info.x info
mv menu.x menu
mv port-ovpn.x port-ovpn
mv port-squid.x port-squid
mv port-ssl.x port-ssl
mv port-sstp.x port-sstp
mv port-tr.x port-tr
mv port-vless.x port-vless
mv port-wg.x port-wg
mv port-ws.x port-ws
mv reboot.x reboot
mv renew-l2tp.x renew-l2tp
mv renew-pptp.x renew-pptp
mv renew-ss.x renew-ss
mv renew-ssh.x renew-ssh
mv renew-ssr.x renew-ssr
mv renew-sstp.x renew-sstp
mv renew-tr.x renew-tr
mv renew-vless.x renew-vless
mv renew-wg.x renew-wg
mv renew-ws.x renew-ws
mv restart.x restart
mv restore.x restore
mv strt.x strt
mv swapkvm.x swapkvm
mv tendang.x tendang
mv trial-ssh.x trial-ssh
mv xp.x xp

#Remove Extension
rm -f *.x.c
clear
echo -e "Encrypt Shell Susuccessful..." | lolcat
rm -f encrypt
cd
rm -rf shc-4.0.2
rm -rf 4.0.2.tar.gz
rm -rf master.zip
