#!/usr/bin/env bash
echo "zagnan ukaz set -e"
set -e

echo "Start php-fpm"
exec php-fpm8 -D

echo "Start nginx"
exec nginx -g 'daemon off;'
