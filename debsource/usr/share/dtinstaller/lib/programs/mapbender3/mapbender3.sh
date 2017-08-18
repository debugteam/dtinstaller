#!/usr/bin/env bash

# === === ### lib to install mapbender3 (GIS - Geo Information System) ### === === #

# Author Jochen Schultz <jschultz@php.net>

# usage: mapbender3

buildvirtualhost() {


}

checkrequirements() {
  message "   checking requirements!  " 3 0
  checkgit
  checkcomposer
  read -n 1 -s -r -p "Press any key to continue"
}

mapbender3() {

  local project mapbender3path
  clear
  checkrequirements
  clear
  message "   create a new mapbender3 project!  " 3 0
  project=$(createproject)
  mapbender3path="$apacheroot/$projectroot/$project/mapbender3"
  message "  clone mapbender-starter from github" 3 0
  echo ""
  sudouser=$(getsudouser)
  sudo -u$sudouser git clone git@github.com:mapbender/mapbender-starter.git $mapbender3path
  currentdir=$(pwd)
  cd $mapbender3path
  value=`git tag`
  #clear
  message "  following tags are available" 3 0
  echo ""
  COUNTER=1
  while IFS='' read -ra TAGS; do
    for i in "${TAGS[@]}"; do
      echo "[$COUNTER] : $i"
      field[$COUNTER]=$i
      ((COUNTER++))
    done
  done <<< "$value"
  echo ""
  echo -e "please select a number: \c "
  read tag
  tag=${field[$tag]}
  clear
  message "  checking out" 3 0
  echo ""
  git checkout "$tag"
  # start installation
  cd application
  message "  running composer - please go get a coffee" 3 0
  echo ""
  
  apacherunuser=$(getapacherunuser)
  sudo -u"$apacherunuser" composer install >> /dev/null 2>&1
  sudo -u"$apacherunuser" composer init-example
  clear
  message "  installing assets - just a few moments" 3 0
  sudo -u"$apacherunuser" app/console assets:install --symlink

  buildvirtualhost $project
  
  main

}
