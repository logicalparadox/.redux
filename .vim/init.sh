#!/bin/bash

VIM_INIT_DIR="$( cd "$( dirname "$0" )" && pwd )"

sudo apt-get install -y vim

cd ~
ln -sf $VIM_INIT_DIR/.vimrc .vimrc

echo "Vim installed from $VIM_INIT_DIR."
