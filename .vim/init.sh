#!/bin/bash

VIM_INIT_DIR="$( cd "$( dirname "$0" )" && pwd )"

apt-get install -y vim

cd ~
ln -sf $VIM_INIT_DIR/.vimrc .vimrc
ln -sf $VIM_INIT_DIR/lib .vim

echo "Vim installed."
