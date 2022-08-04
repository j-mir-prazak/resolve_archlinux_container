#!/bin/bash

echo "INSTALLING NVIDIA AND DAVINCI RESOLVE"

pacman -Syyu --noconfirm fuse3 glu librsvg libxcrypt-compat 'glu' 'gtk2' 'gstreamer' 'libpng12' 'lib32-libpng12' 'ocl-icd' 'openssl-1.0' 'opencl-driver' 'qt5-base' 'qt5-svg' 'qt5-webkit' 'qt5-webengine' 'qt5-websockets' 'libxcrypt-compat'

modprobe fuse

sudo -u $HOSTUSER mkdir -p /tmp/build/

cd /tmp/build/
sudo -u $HOSTUSER mkdir -p /tmp/build/yay/
if [ ! -f /tmp/build/yay/*zst ]; then 
    sudo -u $HOSTUSER git clone https://aur.archlinux.org/yay.git ./yay
    cd yay
    sudo -u $HOSTUSER makepkg --noconfirm -sC  
fi
cd /tmp/build/yay
pacman -U *zst --noconfirm


cd /tmp/build/
sudo -u $HOSTUSER mkdir -p /tmp/build/opencl-nvidia
if [ ! -f /tmp/build/opencl-nvidia/*zst ]; then 
    sudo -u $HOSTUSER yay --noconfirm -S opencl-nvidia --overwrite '*' --builddir=/tmp/build/
else
    cd /tmp/build/opencl-nvidia
    pacman -U *zst --noconfirm --overwrite '*'
fi


cd /tmp/build/
sudo -u $HOSTUSER mkdir -p /tmp/build/nvidia-drivers/
if [ ! -f /tmp/build/nvidia-drivers/*run ]; then
    curl https://us.download.nvidia.com/XFree86/Linux-${ARCH}/${NVIDIA_VERSION}/NVIDIA-Linux-${ARCH}-${NVIDIA_VERSION}.run --output /tmp/build/nvidia.run
fi
cd /tmp/build/nvidia-drivers/
chmod +x ./nvidia.run
bash /tmp/build/nvidia-drivers/nvidia.run --no-kernel-module --no-kernel-module-source --run-nvidia-xconfig --no-backup --no-questions --accept-license --ui=none


# cd /tmp/build/
# sudo -u $HOSTUSER mkdir -p /tmp/build/davinci-resolve-studio/
# if [ ! -f /tmp/build/davinci-resolve/*zst ]; then
#     sudo -u $HOSTUSER yay --noconfirm -S davinci-resolve-studio --overwrite '*' --builddir=/tmp/build/
# else
#     cd /tmp/build/davinci-resolve-studio/
#     pacman -U *zst --noconfirm --overwrite '*'
# fi

cd /tmp/build/
sudo -u $HOSTUSER mkdir -p /tmp/build/davinci-resolve/
if [ ! -f /tmp/build/davinci-resolve/*zst ]; then
    sudo -u $HOSTUSER yay --noconfirm -S davinci-resolve --overwrite '*' --builddir=/tmp/build/
else
    cd /tmp/build/davinci-resolve/
    sudu -u $HOSTUSER makepkg -sU
    pacman -U *zst --noconfirm --overwrite '*'
fi



#sudo -u arch yay --noconfirm -S davinci-resolve
