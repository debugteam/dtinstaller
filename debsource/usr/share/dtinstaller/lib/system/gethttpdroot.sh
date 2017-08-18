#!/usr/bin/env bash

# === === ### function to get the httpdroot directory of apache (normally it is /var/www ### === === #

# Author Jochen Schultz <jschultz@php.net>

# usage:  httpdroot=$(gethttpdroot)

gethttpdroot() {
  local httpdroot
  $httpdroot=$(apachectl -V | grep -oP '(?<=HTTPD_ROOT=")[^"]+(?=")')
  echo $httpdroot
}
