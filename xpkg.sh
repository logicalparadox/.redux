#!/bin/bash

export XPKG_MANAGER=""

#
# Log a message to user
# @param {String} message to log
#

xpkg_log () {
  echo "[$XPKG_MANAGER] $1"
}

#
# Determine if manager exists.
# @param {String} program to check
#

_xpkg_have_program() {
  type "$1" &> /dev/null
}

#
# Figure out the system package manager.
#

_xpkg_set_manager() {
  if _xpkg_have_program apt-get ; then
    XPKG_MANAGER="apt-get"
  elif _xpkg_have_program yum ; then
    XPKG_MANAGER="yum"
  elif _xpkg_have_program pacman ; then
    XPKG_MANAGER="pacman"
  else
    echo "Package manager not supported."
    exit 1
  fi
}

#
# Throw an error an exit.
#

_xpkg_cmd_fail() {
  xpkg_log "last command failed, exiting!"
  exit 1
}

#
# Update the package manager's remote cache.
#

xpkg_update_system() {
  xpkg_log "updating system sources"
  case $XPKG_MANAGER in
    "apt-get")
      sudo apt-get update > /dev/null || _xpkg_cmd_fail
      ;;
    "yum")
      sudo yum -Psu > /dev/null || _xpkg_cmd_fail
      ;;
  esac
}

#
# Do a full upgrade by updating all sources
# then update all installed packages.
#

xpkg_upgrade_system() {
  xpkg_update_system
  xpkg_log "upgrading system packages"
  case $XPKG_MANAGER in
    "apt-get")
      sudo apt-get upgrade -y > /dev/null || _xpkg_cmd_fail
      ;;
    "yum")
      echo "noop"
      ;;
    "pacman")
      sudo pacman -Syu > /dev/null || _xpkg_cmd_fail
  esac
}

#
# Install a package or list of packages. Multiple
# entries will be install singularly.
#

xpkg_install() {
  while IFS=" " read -ra PACKAGES; do
    for i in "${PACKAGES[@]}"; do
      xpkg_log "install $i"
      case $XPKG_MANAGER in
        "apt-get")
          sudo apt-get install -y "$1" > /dev/null || _xpkg_cmd_fail
          ;;
        "pacman")
          sudo pacman -S --noconfirm --needed "$1" >> /dev/null || _xpkg_cmd_fail
          ;;
        "yum")
          echo "  not implemented"
          ;;
      esac
    done
  done <<< "$1"
}

#
# Boot
#

_xpkg_set_manager
