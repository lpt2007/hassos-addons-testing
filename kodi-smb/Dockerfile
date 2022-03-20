ARG BUILD_FROM
# armhf: tianon/raspbian:${VERSION}-slim

FROM ${BUILD_FROM}
#FROM ghcr.io/home-assistant/armhf-base-raspbian:bullseye

# Default ENV
ENV \
    LANG="C.UTF-8" \
    DEBIAN_FRONTEND="noninteractive" \
    CURL_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt" \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_WAIT_FOR_SERVICES=1

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Version
ARG \
    BASHIO_VERSION \
    TEMPIO_VERSION \
    S6_OVERLAY_VERSION

# Base system
WORKDIR /usr/src

RUN \
    set -x \
    && apt-get update && apt-get install -y --no-install-recommends \
        bash \
        jq \
        tzdata \
        curl \
        ca-certificates \
        apt-utils \
        git \
        build-essential  \
        libasound2-dev \
        libffi-dev \
        libssl-dev \
        python-dev \
        python3-pip \
        alsa-base \
        alsa-utils \
        fbset \
    \
    && curl -L -f -s "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-armhf.tar.gz" \
        | tar zxvf - -C / \
    && mkdir -p /etc/fix-attrs.d \
    && mkdir -p /etc/services.d \
    \
    && curl -L -f -s -o /usr/bin/tempio \
        "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_armhf" \
    && chmod a+x /usr/bin/tempio \
    \
    && mkdir -p /usr/src/bashio \
    && curl -L -f -s "https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz" \
        | tar -xzf - --strip 1 -C /usr/src/bashio \
    && mv /usr/src/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/src/*
    
### Install kodi
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 \
&& sh -c "echo 'deb http://ftp.us.debian.org/debian/ bullseye main contrib non-free' >> /etc/apt/sources.list" \
&& sh -c "echo 'deb http://deb.debian.org/debian bullseye main contrib non-free' >> /etc/apt/sources.list" \
&& apt-get update \
&& apt-get install -y kodi

### Install apt deps
#RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install \
###  libraspberrypi-bin=1.20180328-1~nokernel1 libraspberrypi0=1.20180328-1~nokernel1 --allow-downgrades -y \
#  apt-utils \
#  build-essential \
#  libasound2-dev \
#  libffi-dev \
#  libssl-dev \
#  python-dev \
#  python-pip \
#  git \
#  alsa-base \
#  alsa-utils \
#  fbset \
#  kodi \
#  kodi-inputstream-adaptive \
#  libnss3 \
#  && rm -rf /var/lib/apt/lists/*

RUN usermod -a -G input kodi
### Configure for Kodi
#COPY ./rootfs/etc/services.d/kodi-smb/99-input.rules /etc/udev/rules.d/99-input.rules
#COPY ./rootfs/etc/services.d/kodi-smb/0-permissions.rules /etc/udev/rules.d/10-permissions.rules
#RUN addgroup --system input && \
#usermod -a -G audio root && \
#usermod -a -G video root && \
#usermod -a -G input root && \
#usermod -a -G dialout root && \
#usermod -a -G plugdev root && \
#usermod -a -G tty root

### Copy data for add-on and make right privilages
COPY ./rootfs/etc/services.d/kodi-smb/run.sh /run.sh
RUN chmod +x /run.sh

# S6-Overlay
WORKDIR /
#ENTRYPOINT ["/init"]
ENTRYPOINT ["/bin/bash", "-c", "/run.sh"]
