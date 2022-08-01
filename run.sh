#!/bin/bash

chmod -R +x ./APP/

docker run \
    --network host \
    --privileged \
    --mount type=bind,source=/lib/modules,target=/lib/modules \
    --mount type=bind,source=/dev,target=/dev \
    --mount type=bind,source=/tmp,target=/tmp \
    --mount type=bind,source=/var/run/user,target=/var/run/user \
    --mount type=bind,source=/etc/localtime,target=/etc/localtime,readonly \
    --mount type=bind,source=/media,target=/media \
    --mount type=bind,source=/home,target=/home \
    --mount type=bind,source=/opt/resolve,target=/opt/resolve_host \
    --mount type=bind,source=$(pwd)/APP,target=/app,readonly \
    --mount type=bind,source=/etc/machine-id,target=/etc/machine-id \
    --env DISPLAY=$DISPLAY \
    --env HOSTUSER=$USER \
    --env HOSTUSERID=$(id -u) \
    --env PULSE_SERVER=/var/run/user/$(id -u)/pulse/native \
    --name=archresolve \
    --rm \
    -ti \
archresolve:latest /app/resolve.sh
#archresolve:latest sudo -u $USER PULSE_SERVER=/var/run/user/$(id -u)/pulse/native /opt/resolve/bin/resolve
