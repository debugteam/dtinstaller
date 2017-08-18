#!/usr/bin/env bash

# === === ### lib to install symfony framework ### === === #

# Author Jochen Schultz <jschultz@php.net>

# usage: symfony

checkrequirements() {
  message "   checking requirements!  " 3 0
  checkgit
  checkcomposer
  read -n 1 -s -r -p "Press any key to continue"
}

symfony() {

  local project symfonypath
  clear
  checkrequirements
  
  clear
  message "   create a new symfony framework project!  " 3 0
  project=$(createproject)
  
  symfonypath="$apacheroot/$projectroot/$project"
  
  apacherunuser=$(getapacherunuser)
  sudo -u"$apacherunuser" composer create-project symfony/framework-standard-edition $symfonypath

  main
}

