#!/usr/bin/env bash
set -e

echo "Start nginx"
exec nginx -g 'daemon off;'

echo "Start php-fpm"
exec php-fpm81 -D
