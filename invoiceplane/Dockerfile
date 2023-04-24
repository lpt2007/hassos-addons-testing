ARG BUILD_FROM=ghcr.io/hassio-addons/base:13.2.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Install needed software
RUN apk add --no-cache \
        php7 \
        php7-fpm \
        php7-pdo_mysql \
        nginx

# Install InvoicePlane
RUN wget https://github.com/InvoicePlane/InvoicePlane/releases/download/v1.5.11/InvoicePlane-1.5.11.zip && \
    unzip InvoicePlane-1.5.11.zip -d /usr/share/nginx/html && \
    rm InvoicePlane-1.5.11.zip

# Copy the default configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the start script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

