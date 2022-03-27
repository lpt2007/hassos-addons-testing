#!/usr/bin/with-contenv bashio

echo "ONVIF server started"
cd /data/rpos
echo "go to directory /data/rpos"
/usr/local/bin/node /data/rpos/rpos.js
