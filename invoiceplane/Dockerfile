ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM ${BUILD_FROM}

RUN apk update && \
    apk add --no-cache nginx nano php php-cgi php-zlib php-gd php-mysqli php-mbstring php-fpm php-pdo php-pdo_mysql php-json php-openssl php-zip php-curl php-phar php-dom php-xml && \
    rm -rf /var/cache/apk/*

RUN wget -O /tmp/invoiceplane.zip https://github.com/InvoicePlane/InvoicePlane/releases/download/v1.6.1-beta-2/v1.6.1-beta-2.zip && \
    unzip /tmp/invoiceplane.zip -d /var/www && \
#    cp -r /var/www/ip/* /var/www/localhost/htdocs/ && \
    chown -R root:www-data /var/www/ip && \
    chmod -R 775 /var/www/ip/uploads && \
    chmod -R 775 /var/www/ip/application/cache && \
    rm /tmp/invoiceplane.zip

COPY test.php /var/www/ip/test.php
COPY test.html /var/www/ip/test.html

COPY nginx.conf /etc/nginx/nginx.conf
COPY php.ini /etc/php81/conf.d/custom.ini
COPY php.conf /etc/php81/php-fpm.d/custom.conf
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
