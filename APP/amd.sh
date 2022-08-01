#!/bin/bash

echo "INSTALLING NVIDIA AND DAVINCI RESOLVE"

pacman -Syyu --noconfirm fuse3 mesa glu librsvg libxcrypt-compat

modprobe fuse

cd /home/$HOSTUSER
sudo -u $HOSTUSER mkdir -p /home/$HOSTUSER/yay
cd /home/$HOSTUSER/yay
sudo -u $HOSTUSER git clone https://aur.archlinux.org/ncurses5-compat-libs.git ./ncurses5
cd ncurses5
sudo -u $HOSTUSER makepkg -sC --skippgpcheck
pacman -U *zst --noconfirm

#sudo -u $HOSTUSER yay --noconfirm -S ncurses5-compat-libs --overwrite '*' --mflags "--skippgpcheck"

sudo -u $HOSTUSER yay --noconfirm -S opencl-amd --overwrite '*'

pacman -Syyu --noconfirm clinfo

#sudo -u $HOSTUSER yay --noconfirm -S davinci-resolve --overwrite '*'



#sudo -u arch yay --noconfirm -S davinci-resolve