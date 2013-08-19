#!/bin/bash

CONFIG_INIT_DIR="$( cd "$( dirname "$0" )" && pwd )"

sudo apt-get install -y awesome
sudo apt-get install -y rxvt-unicode-256color
sudo apt-get install -y unclutter
sudo apt-get install -y ranger
sudo apt-get install -y caca-utils highlight atool w3m poppler-utils mediainfo

cd ~
ln -sf $CONFIG_INIT_DIR/.xinitrc .xinitrc
ln -sf $CONFIG_INIT_DIR/.Xresources .Xresources
ln -sf $CONFIG_INIT_DIR/lib .config

echo "Desktop configured."
