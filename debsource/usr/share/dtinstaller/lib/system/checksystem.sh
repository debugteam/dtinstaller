#!/usr/bin/env bash

checksystem() {

  local project projectpath
  project=${1}
  projectpath="$apacheroot/$projectroot/$project"
  if [ -d "$projectpath" ]; then
    echo "Project $project allready exists!"
    exit
  else
    apacherunuser=$(getapacherunuser)
    sudo -u"$apacherunuser" mkdir $projectpath
  fi
  
}