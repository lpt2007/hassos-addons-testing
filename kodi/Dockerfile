# Dockerfile

FROM homeassistant/amd64-base-python:3.9-alpine

ENV LANG C.UTF-8

RUN apk add --no-cache kodi \
    && mkdir -p /config/.kodi/userdata \
    && mkdir -p /config/.kodi/addons \
    && mkdir -p /config/.kodi/media \
    && chown -R root:root /usr/lib/kodi \
    && chown -R 1000:1000 /config

EXPOSE 8080

ENTRYPOINT [ "kodi", "--standalone", "--desktop" ]
