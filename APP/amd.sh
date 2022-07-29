#!/bin/bash

echo "INSTALLING NVIDIA AND DAVINCI RESOLVE"

pacman -Syyu --noconfirm fuse3

modprobe fuse

gpg --recv-keys 19882D92DDA4C400C22C0D56CC2AF4472167BE03
gpgconf --kill all
cd /home/$HOSTUSER

sudo -u $HOSTUSER yay --noconfirm -S opencl-amd --overwrite '*'


#sudo -u $HOSTUSER yay --noconfirm -S davinci-resolve --overwrite '*'



#sudo -u arch yay --noconfirm -S davinci-resolve