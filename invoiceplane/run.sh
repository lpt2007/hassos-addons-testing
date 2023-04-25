#!/usr/bin/env bash
set -e

echo "Start php-fpm"
exec php-fpm81 -D

echo "Start nginx"
exec nginx -g 'daemon off;'
