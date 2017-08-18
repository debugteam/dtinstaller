#!/usr/bin/env bash

# === === ### function to get a directory listing and choose a directory to delete ### === === #

# Author Jochen Schultz <jschultz@php.net>

# first argument = directory path - mandatory - can't be root

# usage:  deletedirectory /var/www/vhosts2

deletedirectory() {

  local directory dirs
  directory=${1}
  
  clear
  message "   Delete a project!  " 3 0
  echo ""
  listing=`ls -l $directory | egrep '^d' | awk '{print $9}'`
  echo "0) : [return to menu]"
  echo ""
  counter=1
  while IFS='' read -ra dirs; do
    for dir in "${dirs[@]}"; do
      echo "$counter) : $dir"
      field[counter]=$dir
      ((counter++))
    done
  done <<< "$listing"
  echo ""
  if [ $counter -gt 1 ]; then
    echo -e "Please select a project number to delete: \c "
    read pindex
    if [ $pindex = 0 ]; then
      main
    fi
    if [ ${field[pindex]} ]; then
      echo -e "delete $apacheroot/$projectroot/${field[pindex]}? Please write the word 'yes' : \c"
      read confirm
      if [ $confirm = "yes" ]; then
        rm -rf $apacheroot/$projectroot/${field[pindex]}
        message "  ✔ Project ${field[pindex]} deleted" 1 0
        read -n 1 -s -r -p "Press any key to continue"
      fi
    else
      deletedirectory $directory
    fi
    main
  else
    clear
    message "  ❌ there is no project to delete!" 1 0
    read -n 1 -s -r -p "Press any key to continue"
    main
  fi
    
}