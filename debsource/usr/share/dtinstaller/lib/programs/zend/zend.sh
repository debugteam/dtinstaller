#!/usr/bin/env bash

# === === ### lib to install zend framework ### === === #

# Author Jochen Schultz <jschultz@php.net>

# usage: zend

checkrequirements() {
  message "   checking requirements!  " 3 0
  checkgit
  checkcomposer
  read -n 1 -s -r -p "Press any key to continue"
}

zend() {

  local project zendpath
  clear
  checkrequirements
  
  clear
  message "   create a new zend framework project!  " 3 0
  project=$(createproject)
  
  zendpath="$apacheroot/$projectroot/$project"
  
  apacherunuser=$(getapacherunuser)
  sudo -u"$apacherunuser" composer create-project -s dev zendframework/skeleton-application $zendpath

  main
}

