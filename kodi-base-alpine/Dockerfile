ARG BUILD_FROM
FROM $BUILD_FROM

# Setup base
RUN apk add --no-cache kodi

# Copy data
COPY rootfs /

# default folder
WORKDIR /
