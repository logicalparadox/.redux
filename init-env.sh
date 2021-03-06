#!/bin/bash

INIT_DIR="$( cd "$( dirname "$0" )" && pwd )"

# Dev Tools
sudo apt-get install -y software-properties-common
sudo apt-get install -y curl
sudo apt-get install -y build-essential 
sudo apt-get install -y libssl-dev 
sudo apt-get install -y libreadline6-dev
sudo apt-get install -y libbz2-dev
sudo apt-get install -y libsqlite3-dev 
sudo apt-get install -y zlib1g-dev

# Tmux 
sudo apt-get install -y tmux

# Local Configs
cd ~
ln -sf $INIT_DIR/env/.gitconfig .gitconfig
ln -sf $INIT_DIR/env/.gitignore_global .gitignore_global
ln -sf $INIT_DIR/env/.tmux.conf .tmux.conf
ln -sf $INIT_DIR/env/.ls++.conf .ls++.conf
cd $INIT_DIR

# Sub-modules
sh $INIT_DIR/.zsh/init.sh
sh $INIT_DIR/.vim/init.sh

# Python Env
if [ ! -d ~/.pyenv ]; then
  git clone https://github.com/yyuu/pyenv.git ~/.pyenv
# TODO: auto config version
fi

# Node.js Env
if [ ! -d ~/.nvm ]; then
  git clone https://github.com/creationix/nvm.git ~/.nvm
# TODO: auto config version
fi
