#!/bin/bash

echo "INSTALLING AMD AND DAVINCI RESOLVE"

pacman -Syyu --noconfirm fuse3 mesa glu librsvg libxcrypt-compat 'gstreamer' 'libpng12' 'lib32-libpng12' 'ocl-icd' 'openssl-1.0' 'opencl-driver' 'qt5-base' 'qt5-svg' 'qt5-webkit' 'qt5-webengine' 'qt5-websockets' 'libxcrypt-compat' 'strace'

modprobe fuse

sudo -u $HOSTUSER mkdir -p /tmp/build/

cd /tmp/build/
if [ ! -f /tmp/build/yay/*zst ]; then 
    sudo -u $HOSTUSER git clone https://aur.archlinux.org/yay.git ./yay
    cd yay
    sudo -u $HOSTUSER makepkg --noconfirm -sC  
fi
cd /tmp/build/yay
pacman -U *zst --noconfirm


cd /tmp/build/
if [ ! -f /tmp/build/ncurses5/*zst ]; then 
    sudo -u $HOSTUSER git clone https://aur.archlinux.org/ncurses5-compat-libs.git ./ncurses5
    cd ncurses5
    sudo -u $HOSTUSER makepkg -sC --skippgpcheck
fi
cd /tmp/build/ncurses5/
pacman -U *zst --noconfirm

#sudo -u $HOSTUSER yay --noconfirm -S ncurses5-compat-libs --overwrite '*' --mflags "--skippgpcheck"

if [ ! -f /tmp/build/opencl-amd/*zst ]; then 
    sudo -u $HOSTUSER yay --noconfirm -S opencl-amd --overwrite '*' --builddir=/tmp/build/
else
    cd /tmp/build/opencl-amd/
    pacman -U *zst --noconfirm --overwrite '*'
fi

# cd /tmp/build/
# sudo -u $HOSTUSER mkdir -p /tmp/build/davinci-resolve-studio/
# if [ ! -f /tmp/build/davinci-resolve/*zst ]; then
#     sudo -u $HOSTUSER yay --noconfirm -S davinci-resolve --overwrite '*' --builddir=/tmp/build/
# else
#     cd /tmp/build/davinci-resolve/
#     sudu -u $HOSTUSER makepkg -sU
#     pacman -U *zst --noconfirm --overwrite '*'
# fi

cd /tmp/build/
sudo -u $HOSTUSER mkdir -p /tmp/build/davinci-resolve-studio/
if [ ! -f /tmp/build/davinci-resolve/*zst ]; then
    sudo -u $HOSTUSER yay --noconfirm -S davinci-resolve-studio --overwrite '*' --builddir=/tmp/build/
else
    cd /tmp/build/davinci-resolve-studio/
    sudo -u $HOSTUSER makepkg -sU
    pacman -U *zst --noconfirm --overwrite '*'
fi

pacman -Syyu --noconfirm clinfo

#rm /home/$HOSTUSER/* -rf
