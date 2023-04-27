#!/usr/bin/env bash
set -e

echo "Start php-fpm"
php-fpm81 -D

echo "Start nginx"
nginx -g 'daemon off;'
