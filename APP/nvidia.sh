#!/bin/bash

echo "INSTALLING NVIDIA AND DAVINCI RESOLVE"

pacman -Syyu --noconfirm fuse3

modprobe fuse

cd /home/$HOSTUSER

sudo -u $HOSTUSER yay --noconfirm -S opencl-nvidia --overwrite '*'

curl https://us.download.nvidia.com/XFree86/Linux-${ARCH}/${NVIDIA_VERSION}/NVIDIA-Linux-${ARCH}-${NVIDIA_VERSION}.run --output nvidia.run
chmod +x ./nvidia.run

bash ./nvidia.run --no-kernel-module --no-kernel-module-source --run-nvidia-xconfig --no-backup --no-questions --accept-license --ui=none

sudo -u $HOSTUSER yay --noconfirm -S davinci-resolve --overwrite '*'



#sudo -u arch yay --noconfirm -S davinci-resolve