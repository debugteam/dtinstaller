#!/usr/bin/env bash

dnsmasqhelper() {
  clear
  message "  this will install dnsmasq and make entries in NetworkManager.conf, dnsmasq.conf and dhclient.conf" 3 0
  echo ""
  echo -e "Do you want to enable http://{projectname}.dev? Please write the word 'yes' : \c"
  read confirm
  if [ $confirm = "yes" ]; then
    apt-get install dnsmasq
    sed -i -e 's/dns=dnsmasq/\#dns=dnsmasq/g' /etc/NetworkManager/NetworkManager.conf
    sed -i -e 's/\#\#dns=dnsmasq/\#dns=dnsmasq/g' /etc/NetworkManager/NetworkManager.conf
    sed -i '/listen-address=127.0.0.1/d' /etc/dnsmasq.conf
    sed -i '/bind-interfaces/d' /etc/dnsmasq.conf
    sed -i '/address=\/dev\/127.0.0.1/d' /etc/dnsmasq.conf
    echo 'listen-address=127.0.0.1' >> /etc/dnsmasq.conf
    echo 'bind-interfaces' >> /etc/dnsmasq.conf
    echo 'address=/dev/127.0.0.1' >> /etc/dnsmasq.conf
    kill $(netstat -plant | grep :53 | grep -o '[0-9]*/dnsmasq' | grep -o '[0-9]*')
    service dnsmasq restart
    sed -i '/prepend domain-name-servers 127.0.0.1;/d' /etc/dhcp/dhclient.conf
    echo 'prepend domain-name-servers 127.0.0.1;' >> /etc/dhcp/dhclient.conf
    service network-manager restart
    clear
    message "  ✔ everything set up" 2 3
    read -n 1 -s -r -p "Press any key to continue"
  fi
  main
}