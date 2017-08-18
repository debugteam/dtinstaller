#!/usr/bin/env bash

# === === ### function to check if a service is running ### === === #

# Author Jochen Schultz <jschultz@php.net>

# usage:  apache2=$(checkservice apache2)

checkservice() {

  local service
  service=${1}
  
  if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
  then
    echo 1
  else
    echo 0
  fi

}