#!/bin/bash

VIM_INIT_DIR="$( cd "$( dirname "$0" )" && pwd )"
source $VIM_INIT_DIR/../xpkg.sh

xpkg_install vim

cd ~
ln -sf $VIM_INIT_DIR/.vimrc .vimrc

echo "Vim installed from $VIM_INIT_DIR."
