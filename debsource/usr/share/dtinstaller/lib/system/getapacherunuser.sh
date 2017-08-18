#!/usr/bin/env bash

# === === ### function to get the APACHE_RUN_USER from envvars ### === === #

# Author Jochen Schultz <jschultz@php.net>

# usage:  apacherunuser=$(getapacherunuser)

getapacherunuser() {
  local runuser
  runuser=$(grep -oP '(?<=APACHE_RUN_USER=).*' /etc/apache2/envvars)
  echo $runuser
}
