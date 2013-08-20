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


sh $INIT_DIR/.zsh/init.sh
sh $INIT_DIR/.vim/init.sh

if [ ! -d ~/.pyenv ]; then
  git clone https://github.com/yyuu/pyenv.git ~/.pyenv
fi

if [ ! -d ~/.nvm ]; then
  git clone https://github.com/creationix/nvm.git ~/.nvm
fi
