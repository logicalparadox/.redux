#!/bin/bash

ZSH_INIT_DIR="$( cd "$( dirname "$0" )" && pwd )"

apt-get install -y language-pack-en
locale-gen en_US.UTF-8
dpkg-reconfigure locales

apt-get install -y zsh

cd ~
ln -sf $ZSH_INIT_DIR/.zshrc .zshrc
ln -sf $ZSH_INIT_DIR/lib .zsh

echo "ZSH installed. Run 'chsh -s $(which zsh)'" 
