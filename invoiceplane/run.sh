#!/usr/bin/env bash

# Start PHP-FPM
php-fpm7 --nodaemonize &

# Start Nginx
nginx -g "daemon off;"
