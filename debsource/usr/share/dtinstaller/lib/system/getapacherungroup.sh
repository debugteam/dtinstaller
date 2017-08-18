#!/usr/bin/env bash

# === === ### function to get the APACHE_RUN_GROUP from envvars ### === === #

# Author Jochen Schultz <jschultz@php.net>

# usage:  apacherungroup=$(getapacherungroup)

getapacherungroup() {
  local rungroup
  rungroup=$(grep -oP '(?<=APACHE_RUN_GROUP=).*' /etc/apache2/envvars)
  echo $rungroup
}