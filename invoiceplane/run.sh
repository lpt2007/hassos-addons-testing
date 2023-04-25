#!/usr/bin/env bash
set -e

# Start php-fpm
php-fpm8 -D

# Start nginx
nginx -g 'daemon off;'
