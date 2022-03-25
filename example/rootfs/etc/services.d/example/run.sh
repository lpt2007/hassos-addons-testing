#!/usr/bin/with-contenv bashio

echo "Starting..."
v4l2rtspserver -W 1920 -H 1088 -F 15 -P 8554 /dev/video0
