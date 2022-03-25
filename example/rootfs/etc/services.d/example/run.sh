#!/usr/bin/with-contenv bashio

echo "Starting..."
v4l2rtspserver -W 1920 -H 1088 -F 15 -P 8554 /dev/video0

### Wait script - waiting rtsp server to start
x=10
while [ $x -gt 0 ]
do
sleep 1s
clear
echo "$x seconds"
x=$(( $x - 1 ))
done
echo "RTSP server started"
