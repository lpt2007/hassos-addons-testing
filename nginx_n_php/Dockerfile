ARG BUILD_FROM
FROM $BUILD_FROM

# Setup base
RUN apk add --no-cache nginx openssl \
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
                             mailcap

# Copy data
COPY rootfs /

WORKDIR /

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
