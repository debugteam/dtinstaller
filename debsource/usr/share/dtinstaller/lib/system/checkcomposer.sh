#!/usr/bin/env bash


installcomposer() {
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  php composer-setup.php --install-dir=/usr/bin --filename=composer
  php -r "unlink('composer-setup.php');"
  clear
  checkcomposer
}

checkcomposer() {
  
  if git --version &>/dev/null; then
    apacherunuser=$(getapacherunuser)
    version=$(sudo -u$apacherunuser composer -V | grep -oP 'version.*' | grep -oP ' .*?(?= )' | head -1)
    message "  ✔ Composer Version:$version is installed" 2 3
  else
    clear
    message "   ATTENTION Composer is not installed  " 1 3
    echo ""
    echo "1) install it and go on"
    echo "2) exit"
    echo ""
    echo -e "Please choose an option: \c "
    read option
    case $option in
        1) installcomposer
          ;;
        2) exit;;
    esac
  fi
  return 1
  
}

