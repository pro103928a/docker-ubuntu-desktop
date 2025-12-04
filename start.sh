#!/bin/bash

rm -f /tmp/.X1-lock
rm -f /tmp/.X11-unix/X1

vncserver :1 -geometry 1280x720 -depth 24 -SecurityTypes None -localhost no --I-KNOW-THIS-IS-INSECURE

/usr/share/novnc/utils/launch.sh --vnc localhost:5901 --listen 6080
