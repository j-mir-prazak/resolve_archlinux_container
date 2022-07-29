#!/bin/bash

HOSTUSER=$USER
HOSTUSERID=$(id -u)

export HOSTUSER=$USER
export HOSTUSERID="$(id -u)"

echo $HOSTUSER
echo $HOSTUSERID

docker build --build-arg HOSTUSER --build-arg HOSTUSERID -t archresolve-build .

docker run \
    --network host \
    --cap-add=ALL \
    --privileged \
    --mount type=bind,source=/lib/modules,target=/lib/modules \
    --mount type=bind,source=/dev,target=/dev \
    --mount type=bind,source=/tmp,target=/tmp \
    --mount type=bind,source=/var/run/user,target=/var/run/user \
    --mount type=bind,source=/etc/localtime,target=/etc/localtime,readonly \
    --env DISPLAY=$DISPLAY \
    --env ARCH="$(arch)" \
    --name=archresolve-build \
    -dit \
archresolve-build /bin/bash

docker exec -ti archresolve-build /app/amd.sh

docker commit archresolve-build archresolve:latest

docker stop archresolve-build
docker rm archresolve-build

docker image rm archresolve-build