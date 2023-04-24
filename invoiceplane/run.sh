#!/usr/bin/env bash

# Start PHP-FPM
php-fpm8 --nodaemonize &

# Start Nginx
nginx -g "daemon off;"
