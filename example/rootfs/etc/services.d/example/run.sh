#!/usr/bin/with-contenv bashio

echo "Starting..."
v4l2rtspserver -W 640 -H 480 -F 15 -P 8554 /dev/video0
