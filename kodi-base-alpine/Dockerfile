ARG BUILD_FROM
FROM $BUILD_FROM

# Base Dependencies
RUN apk update && \
    apk add --no-cache alpine-sdk cmake g++ make nano
    
# Essential Dependencies
RUN apk update && \
    apk add --no-cache mesa-dev libva-dev libxslt-dev libjpeg-turbo-dev
    
# install kodi
RUN apk add --no-cache kodi

# Copy data
#COPY rootfs /

# default folder
WORKDIR /
