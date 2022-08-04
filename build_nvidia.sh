#!/bin/bash

mkdir -p $(pwd)/private
mkdir -p $(pwd)/private/.licence
mkdir -p $(pwd)/build
mkdir -p $(pwd)/resolve
mkdir -p $(pwd)/resolve_studio

cp /etc/hostid $(pwd)/private/hostid
cp /etc/machine-id $(pwd)/private/machine-id

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
    --mount type=bind,source=$(pwd)/build/,target=/tmp/build \
    --mount type=bind,source=$(pwd)/resolve,target=/opt/resolve \
    --env DISPLAY=$DISPLAY \
    --env ARCH="$(arch)" \
    --env NVIDIA_VERSION="$(nvidia-smi -h | head -n1 | awk '{print $6}' | perl -pE 's/v//g')" \
    --name=archresolve-build \
    -dit \
archresolve-build /bin/bash

docker exec -ti archresolve-build /app/nvidia.sh

docker commit archresolve-build archresolve:latest

docker stop archresolve-build
docker rm archresolve-build

docker image rm archresolve-build
