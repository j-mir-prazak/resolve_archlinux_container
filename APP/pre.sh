#!/bin/bash

echo "DOCKER INSIDE."

echo $HOSTUSER
echo $HOSTUSERID


chmod -R +x /app/*

useradd $HOSTUSER
mkdir -p /home/$HOSTUSER
chown -R $HOSTUSER:$HOSTUSER /home/$HOSTUSER
usermod -u $HOSTUSERID $HOSTUSER

pacman -Sy --noconfirm sudo
pacman -Sy --needed --noconfirm git base-devel sudo vim nano go core/usbutils bash-completion pulseaudio-alsa

usermod -aG wheel root
usermod -aG wheel $HOSTUSER

echo "%wheel ALL=(ALL:ALL) ALL" | tee -a /etc/sudoers
echo "%wheel ALL=NOPASSWD: ALL" | tee -a /etc/sudoers

echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist\n" | sudo tee -a /etc/pacman.conf
pacman -Syyu --noconfirm

cd /home/$HOSTUSER
pwd
sudo -u $HOSTUSER git clone https://aur.archlinux.org/yay.git
cd yay
sudo -u $HOSTUSER makepkg --noconfirm -si 

