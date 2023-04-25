ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM ${BUILD_FROM}

RUN apk update && \
#    apk add --no-cache nginx php8 php8-fpm php8-pdo php8-pdo_mysql php8-json php8-openssl php8-zip php8-curl php8-phar php8-dom php8-xml && \
    apk add --no-cache nginx && \
    rm -rf /var/cache/apk/*

RUN wget -O /tmp/invoiceplane.zip https://github.com/InvoicePlane/InvoicePlane/releases/download/v1.6.1-beta-2/v1.6.1-beta-2.zip && \
    unzip /tmp/invoiceplane.zip -d /var/www && \
    chown -R nobody:nobody /var/www/ip && \
    chmod -R 775 /var/www/ip/uploads && \
    chmod -R 775 /var/www/ip/application/cache && \
    rm /tmp/invoiceplane.zip

COPY nginx.conf /etc/nginx/nginx.conf
COPY php.ini /etc/php8/conf.d/custom.ini
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Install tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static /bin/tini
RUN chmod +x /bin/tini

CMD ["/bin/tini", "--", "/run.sh"]
