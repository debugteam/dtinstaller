#!/usr/bin/env bash

checkenvironment() {

  clear
  message "  check if the projectroot exists" 3 0
  
  if [ -d "$apacheroot/$projectroot" ]; then
    message "  ✔  $apacheroot/$projectroot does exists!" 2 3
  else
    
    message "   ATTENTION! Projectroot: $apacheroot/$projectroot does not exists!  " 1 0
    echo ""
    echo "1) create it and go on"
    echo "2) exit"
    echo ""
    echo -e "Please choose an option: \c "
    read option
    case $option in
        1) prepareenvironment
          ;;
        2) exit;;
    esac
  fi
  read -n 1 -s -r -p "Press any key to continue"
  main

}