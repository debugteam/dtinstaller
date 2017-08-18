#!/usr/bin/env bash


installgit() {
  apt install git
  clear
  checkgit
}

checkgit() {
  
  if git --version &>/dev/null; then
    version=$(git --version | grep -oP 'version.*' | grep -oP ' .*')
    message "  ✔ Git Version:$version is installed" 2 3
  else
    clear
    message "   ATTENTION Git is not installed  " 1 3
    echo ""
    echo "1) install it and go on"
    echo "2) exit"
    echo ""
    echo -e "Please choose an option: \c "
    read option
    case $option in
        1) installgit
          ;;
        2) exit;;
    esac
  fi
  return 1
  
}
