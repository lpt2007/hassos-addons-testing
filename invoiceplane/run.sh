#!/usr/bin/env bash
echo "zagnan ukaz set -e"
set -e

echo "Start php-fpm"
php-fpm8 -D

echo "Start nginx"
nginx -g 'daemon off;'
