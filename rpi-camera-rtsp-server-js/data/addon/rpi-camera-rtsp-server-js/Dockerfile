FROM ghcr.io/home-assistant/armhf-base-raspbian:bullseye

# Install requirements for add-on
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git
    
# So let's set it to our add-on persistent data directory.
WORKDIR /data

# install v4lrtsp server from git
RUN git clone https://github.com/mpromonet/v4l2rtspserver.git \
    && cd v4l2rtspserver/ \
    && cmake . \
    && make \
    && make install

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]