#!/bin/bash

echo "DOCKER PREP."

echo $HOSTUSER
echo $HOSTUSERID


chmod -R +x /app/*

useradd $HOSTUSER
mkdir -p /home/$HOSTUSER
chown -R $HOSTUSER:$HOSTUSER /home/$HOSTUSER
usermod -u $HOSTUSERID $HOSTUSER

pacman -Sy --noconfirm sudo
pacman -Sy --needed --noconfirm git base-devel sudo vim nano go core/usbutils bash-completion pulseaudio-alsa gnupg

usermod -aG wheel root
usermod -aG wheel $HOSTUSER

echo "%wheel ALL=(ALL:ALL) ALL" | tee -a /etc/sudoers
echo "%wheel ALL=NOPASSWD: ALL" | tee -a /etc/sudoers

echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist\n" | sudo tee -a /etc/pacman.conf
pacman -Syyu --noconfirm



