#!/usr/bin/env bash

checkservices() {

  clear
  message "  check if apache and mysql are running" 3 0
  
  apache2=$(checkservice apache2)
  if [ "$apache2" = 1 ]; then
    message "  ✔ apache2 service running!" 2 3
  else
    message "  ❌ apache2 service not running!" 1 0
    echo "" >/dev/tty
    echo -e "Do you want me to try to start it (Yn)?: \c " >/dev/tty
    read startapache
    if [ "$startapache" = 'Y' ]; then
      service apache2 start
    fi
  fi

  mysqld=$(checkservice mysqld)
  if [ "$mysqld" = 1 ]; then
    message "  ✔ mysqld service running!" 2 3
  else
    message "  ❌ mysqld service not running!" 1 0
    echo "" >/dev/tty
    echo -e "Do you want me to try to start it (Yn)?: \c " >/dev/tty
    read startapache
    if [ "$startapache" = 'Y' ]; then
      service mysqld start
    fi
  fi
  read -n 1 -s -r -p "Press any key to continue"
  main
  
}