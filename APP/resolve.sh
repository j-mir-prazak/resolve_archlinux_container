#!/bin/bash

cp /app/tracefile /usr/local/bin/
chmod +x /usr/local/bin/tracefile

useradd $HOSTUSER
usermod -u $HOSTUSERID $HOSTUSER
usermod -aG wheel $HOSTUSER
usermod -aG video,audio,systemd-timesync,systemd-network,systemd-resolve,power,network,log,mail,bin,daemon,dbus,render,rfkill,rtkit,root $HOSTUSER

sudo -u $HOSTUSER PULSE_SERVER=/var/run/user/$HOSTUSERID/pulse/native /opt/resolve/bin/resolve
#/bin/bash