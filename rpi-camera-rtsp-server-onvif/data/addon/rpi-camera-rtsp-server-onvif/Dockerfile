FROM ghcr.io/home-assistant/armhf-base-raspbian:bullseye

# Install requirements for add-on
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    liblivemedia-dev \
    liblivemedia-dev \
    liblog4cpp5-dev \
    cmake \
    libasound2-dev
    
# So let's set it to our add-on persistent data directory.
WORKDIR /data

# install onvif server
# install npm and node.js (latest 17 in 26.3.22)
RUN npm install -g n \
    && n install 17
RUN git clone https://github.com/BreeeZe/rpos.git \
    && cd rpos \
    && npm install \
    && npx gulp \
#    && sh setup_v4l2rtspserver.sh
    
# instal v4l2rtspserver
RUN git clone https://github.com/mpromonet/v4l2rtspserver.git \
    && cd v4l2rtspserver/ \
    && cmake . \
    && make \
    && make install

# Copy data for add-on
COPY rposConfig.json /data/rpos/
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
