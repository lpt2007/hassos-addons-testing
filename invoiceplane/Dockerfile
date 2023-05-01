ARG BUILD_FROM=ghcr.io/hassio-addons/base-python:13.2.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}
#ARG ARCH=
#FROM ${ARCH}alpine:3.17

LABEL Maintainer="Ernesto Serrano <info@ernesto.es>" \
      Description="Lightweight container with Nginx & PHP-FPM based on Alpine Linux."
      
# ustvarjanje nove točke za priključitev datotečnega sistema
#VOLUME /var/www/html

# Install packages
RUN apk --no-cache add \
        php81 \
        php81-fpm \
        php81-opcache \
        php81-pecl-apcu \
        php81-mysqli \
        php81-pgsql \
        php81-json \
        php81-openssl \
        php81-curl \
        php81-zlib \
        php81-soap \
        php81-xml \
        php81-fileinfo \
        php81-phar \
        php81-intl \
        php81-dom \
        php81-xmlreader \
        php81-ctype \
        php81-session \
        php81-iconv \
        php81-tokenizer \
        php81-zip \
        php81-simplexml \
        php81-mbstring \
        php81-gd \
        nginx \
        runit \
        curl \
#        bash \
#        yaml \
# Bring in gettext so we can get `envsubst`, then throw
# the rest away. To do this, we need to install `gettext`
# then move `envsubst` out of the way so `gettext` can
# be deleted completely, then move `envsubst` back.
    && apk add --no-cache --virtual .gettext gettext \
    && mv /usr/bin/envsubst /tmp/ \
    && runDeps="$( \
        scanelf --needed --nobanner /tmp/envsubst \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
    )" \
    && apk add --no-cache $runDeps \
    && apk del .gettext \
    && mv /tmp/envsubst /usr/local/bin/ \
# Remove alpine cache
    && rm -rf /var/cache/apk/* \
# Remove default server definition
    && rm /etc/nginx/http.d/default.conf \
# Make sure files/folders needed by the processes are accessable when they run under the nobody user
    && chown -R nobody.nobody /run \
    && chown -R nobody.nobody /var/lib/nginx \
    && chown -R nobody.nobody /var/log/nginx

# Add configuration files
COPY --chown=nobody rootfs/ /

RUN chmod +x /etc/service/php/run
RUN chmod +x /etc/service/nginx/run
#RUN chmod +x /etc/service/ip/run
RUN chmod +x /docker-entrypoint-init.d/02-ip.sh

# Add shered folder between haos and addon
#RUN mkdir -p /share/invoiceplane
RUN chown -R nobody:nobody /var/www

# Switch to use a non-root user from here on
USER nobody

# Add application
WORKDIR /var/www

# Expose the port nginx is reachable on
EXPOSE 8080

# Let runit start nginx & php-fpm
#RUN chmod +x /bin/docker-entrypoint.sh
#CMD [ "/bin/docker-entrypoint.sh" ]
CMD [ "/init" ]
# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping

ENV client_max_body_size=2M \
    clear_env=no \
    allow_url_fopen=On \
    allow_url_include=Off \
    display_errors=Off \
    file_uploads=On \
    max_execution_time=0 \
    max_input_time=-1 \
    max_input_vars=1000 \
    memory_limit=128M \
    post_max_size=8M \
    upload_max_filesize=2M \
    zlib_output_compression=On
