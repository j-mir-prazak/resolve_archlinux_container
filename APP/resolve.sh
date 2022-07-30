#!/bin/bash


useradd $HOSTUSER
usermod -u $HOSTUSERID $HOSTUSER
usermod -aG video,audio,systemd-timesync,systemd-network,systemd-resolve,power,network,log,mail,bin,daemon,dbus,render,rfkill,rtkit,root $HOSTUSER

sudo -u $HOSTUSER PULSE_SERVER=/var/run/user/$(id -u)/pulse/native /opt/resolve/bin/resolve
