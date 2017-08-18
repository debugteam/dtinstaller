#!/usr/bin/env bash

# === === ### helper for output ### === === #

# Author Jochen Schultz <jschultz@php.net>

# first argument = message to show on shell - mandatory
# second argument = background color - optional - defaults to 0
# third argument = font color - optional - defaults to 7
# fourth argument = width - optional - defaults to 120

# Num  Colour    #define         R G B
# 0    black     COLOR_BLACK     0,0,0
# 1    red       COLOR_RED       1,0,0
# 2    green     COLOR_GREEN     0,1,0
# 3    yellow    COLOR_YELLOW    1,1,0
# 4    blue      COLOR_BLUE      0,0,1
# 5    magenta   COLOR_MAGENTA   1,0,1
# 6    cyan      COLOR_CYAN      0,1,1
# 7    white     COLOR_WHITE     1,1,1

# usage:  message " [error] this is an error message with red background and black font color" 1 0

message() {
  local str color bgcolor strlen boxwidth end bgcolorcode fontcolorcode
  str=${1}
  strlen=${#1}
  boxwidth=100
  if [ -z "$1" ]; then echo "undefined message"; exit; fi
  if [ -z "$2" ]; then bgcolorcode="0"; else bgcolorcode=${2}; fi
  if [ -z "$3" ]; then fontcolorcode="7"; else fontcolorcode=${3}; fi
  if [ -z "$4" ]; then boxwidth=120; else boxwidth={4}; fi
  bgcmd="tput setab $bgcolorcode"
  bgcolor=$($bgcmd)
  colcmd="tput setaf $fontcolorcode"
  color=$($colcmd)
  normal=$(tput sgr0)

  # calculate how many spaces we have to add to our message to reach box size
  end=$(( $boxwidth-$strlen )); for i in $(seq 1 $end); do str="$str "; done

  # we want to print as many empty spaces as the box should be wide - at least twice
  # so we store that many spaces in a variable
  whites=""; for i in $(seq 1 $boxwidth); do whites="$whites "; done
  
  echo "${color}${bgcolor}" >/dev/tty
  echo "$whites" >/dev/tty
  echo "$str" >/dev/tty
  echo "$whites${normal}" >/dev/tty

}