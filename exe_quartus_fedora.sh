#!/bin/sh   

sudo podman run --rm -ti  -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v $(pwd):/home/usuari:rw -e DISPLAY=$DISPLAY --user=$(id -u):$(id -g) --ipc=host --cap-add=SYS_PTRACE --security-opt seccomp=unconfined registry.gitlab.com/axtaor/practicas-ac2:latest /root/runquartus.sh
