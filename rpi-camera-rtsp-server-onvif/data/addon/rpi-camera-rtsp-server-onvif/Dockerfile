FROM ghcr.io/home-assistant/armhf-base-raspbian:bullseye

# Install requirements for add-on
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    liblivemedia-dev \
    liblivemedia-dev \
    liblog4cpp5-dev \
    cmake \
    libasound2-dev \
    v4l-utils
    
# So let's set it to our add-on persistent data directory.
WORKDIR /elits

# install onvif server
# install npm and node.js (latest 17 in 26.3.22)
RUN npm install -g n \
    && n install 17
RUN git clone https://github.com/BreeeZe/rpos.git \
    && cd rpos \
    && npm install

# So let's set it to our add-on persistent data/rpos directory.
WORKDIR /elits/rpos 

RUN npx gulp
    
# instal v4l2rtspserver
RUN git clone https://github.com/mpromonet/v4l2rtspserver.git \
    && cd v4l2rtspserver/ \
    && cmake . \
    && make \
    && make install

# Copy data for add-on
COPY rposConfig.json /elits/rpos/
COPY run /etc/services.d/rpos/run
COPY finish /etc/services.d/rpos/finish

ENTRYPOINT ["/init"]
