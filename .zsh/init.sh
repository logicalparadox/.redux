#!/bin/bash

ZSH_INIT_DIR="$( cd "$( dirname "$0" )" && pwd )"
. $ZSH_INIT_DIR/../xpkg.sh

xpkg_install zsh

cd ~
ln -sf $ZSH_INIT_DIR/.zshrc .zshrc
ln -sf $ZSH_INIT_DIR/lib .zsh

echo "ZSH installed. Run 'chsh -s $(which zsh)'" 
