#!/bin/bash

INIT_DIR="$( cd "$( dirname "$0" )" && pwd )"
source $INIT_DIR/xpkg.sh

# Upgrade System
xpkg_upgrade_system

# Per-OS packages
case $XPKG_MANAGER in
  "pacman")
    xpkg_install base-devel
    xpkg_install sqlite
    xpkg_install readline
    ;;
  "apt-get")
    xpkg_install build-essential
    xpkg_install libssl-dev
    xpkg_install libreadline6-dev
    xpkg_install libbz2-dev
    xpkg_install libsqlite3-dev
    xpkg_install zlib1g-dev
esac

# Same package names
xpkg_install curl
xpkg_install tmux

$INIT_DIR/.zsh/init.sh
$INIT_DIR/.vim/init.sh

# Local Configs
cd ~
ln -sf $INIT_DIR/env/.gitconfig .gitconfig
ln -sf $INIT_DIR/env/.gitignore_global .gitignore_global
ln -sf $INIT_DIR/env/.tmux.conf .tmux.conf
ln -sf $INIT_DIR/env/.ls++.conf .ls++.conf
cd $INIT_DIR

# Python Env
if [ ! -d ~/.pyenv ]; then
  git clone https://github.com/yyuu/pyenv.git ~/.pyenv
# TODO: auto config version
fi

# Ruby Env
if [ ! -d ~/.rvm ]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
# TODO: auto config version
fi

# Node.js Env
if [ ! -d ~/.nvm ]; then
  git clone https://github.com/creationix/nvm.git ~/.nvm
# TODO: auto config version
fi
