#!/bin/bash

INIT_DIR="$( cd "$( dirname "$0" )" && pwd )"

sh $INIT_DIR/.zsh/init.sh
sh $INIT_DIR/.vim/init.sh

cd ~
ln -sf $INIT_DIR/.config .config
ln -sf $INIT_DIR/.xinitrc .xinitrc
