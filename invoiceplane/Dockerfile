ARG BUILD_FROM=ghcr.io/hassio-addons/base:13.2.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Install needed software
RUN apk add --no-cache \
        php8 \
        php8-fpm \
        php8-pdo_mysql \
        nginx

# Install InvoicePlane
RUN wget https://github.com/InvoicePlane/InvoicePlane/releases/download/v1.6.1-beta-2/v1.6.1-beta-2.zip && \
    unzip v1.6.1-beta-2.zip -d /usr/share/nginx/html && \
    rm v1.6.1-beta-2.zip

# Copy the default configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the start script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

