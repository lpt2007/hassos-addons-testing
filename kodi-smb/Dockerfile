#FROM ${BUILD_FROM}
FROM ghcr.io/home-assistant/armhf-base-raspbian:bullseye

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
###        libraspberrypi0 \
    
### Install kodi
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 \
&& sh -c "echo 'deb http://ftp.us.debian.org/debian/ bullseye main contrib non-free' >> /etc/apt/sources.list" \
&& sh -c "echo 'deb http://deb.debian.org/debian bullseye main contrib non-free' >> /etc/apt/sources.list" \
&& apt-get update \
&& apt-get install -y kodi

#  && rm -rf /var/lib/apt/lists/*

### Configure for Kodi
COPY ./rootfs/etc/services.d/kodi-smb/99-input.rules /etc/udev/rules.d/99-input.rules
COPY ./rootfs/etc/services.d/kodi-smb/10-permissions.rules /etc/udev/rules.d/10-permissions.rules
RUN addgroup --system input && \
usermod -a -G audio root && \
usermod -a -G video root && \
usermod -a -G input root && \
usermod -a -G dialout root && \
usermod -a -G plugdev root && \
usermod -a -G tty root

RUN tee -a /etc/udev/rules.d/998-fix-input.rules <<_EOF_
# input
KERNEL=="mouse*|mice|event*",   MODE="0660", GROUP="input"
KERNEL=="ts[0-9]*|uinput",      MODE="0660", GROUP="input"
KERNEL=="js[0-9]*",             MODE="0660", GROUP="input"

# tty
SUBSYSTEM=="tty", KERNEL=="tty[0-9]*", GROUP="tty", MODE="0666"
_EOF_

RUN export LIBVA_DRIVER_NAME=v4l2_request

### Copy data for add-on and make right privilages
COPY ./rootfs/etc/services.d/kodi-smb/run.sh /run.sh
RUN chmod +x /run.sh

# S6-Overlay
WORKDIR /
#ENTRYPOINT ["/init"]
ENTRYPOINT ["/bin/bash", "-c", "/run.sh"]
