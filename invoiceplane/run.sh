#!/usr/bin/env bash

docker run --rm -it \
    -v /var/www/html/invoiceplane:/var/www/html/invoiceplane \
    -p 8080:80 \
    mhzawadi/invoiceplane
