#!/usr/bin/env bash

# === === ### function to get the username of a sudo user ### === === #

# Author Jochen Schultz <jschultz@php.net>

# usage:  sudouser=$(getsudouser)

getsudouser() {
  local SUDO_USER user
  SUDO_USER=$(who|awk '{print $1}')
  [ $SUDO_USER ] && user=$SUDO_USER || user=`whoami`
  # message "writing directly to console" 0 1
  echo $user
}

