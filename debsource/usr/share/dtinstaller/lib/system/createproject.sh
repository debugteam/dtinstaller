#!/usr/bin/env bash

createproject() {

  local project
  echo "" >/dev/tty
  echo -e "please select a projectname: \c " >/dev/tty
  read project
  checksystem $project
  echo $project
  
}