#!/usr/bin/env bash

# === === ### lib to install os system "ilias" (e-learning) ### === === #

# Author Jochen Schultz <jschultz@php.net>

# usage: ilias

checkrequirements() {
  message "   checking requirements!  " 3 0
  checkgit
  checkimagemagic
  read -n 1 -s -r -p "Press any key to continue"
}

ilias() {

  local project iliaspath
  clear
  checkrequirements
  
  clear
  message "   create a new ilias project!  " 3 0
  project=$(createproject)
  
  iliaspath="$apacheroot/$projectroot/$project/ilias"
  
  sudouser=$(getsudouser)
  sudo -u$sudousergit clone https://github.com/ILIAS-eLearning/ILIAS.git $iliaspath
  
  # directories mode SHOULD be 644 for files and 755 for directories
  # change $iliaspath mode to 755
  chmod -R 755 $iliaspath
  # change only file modes to 644 which keeps directories on 755
  find $iliaspath -type f -exec chmod 644 -- {} +
  
  # change owner and group to APACHE_RUN_{USER,GROUP}
  apacherunuser=$(getapacherunuser)
  apacherungroup=$(getapacherungroup)
  chown $apacherunuser:$apacherungroup $iliaspath -R

  main
}

