#!/bin/bash

## Reference https://github.com/hvalev/shiny-server-arm-docker/
set -e

## build ARGs
NCPUS=${NCPUS:--1}

ENV V_ShinyServer=v1.5.20.1002

# Set python3 as the default python
RUN rm /usr/bin/python && \
    ln -s /usr/bin/python3 /usr/bin/python

# Install shiny-server with fix for arm architectures
WORKDIR /
RUN git clone --depth 1 --branch ${V_ShinyServer} https://github.com/rstudio/shiny-server.git && \
    mkdir shiny-server/tmp
COPY binding.gyp /shiny-server/tmp/binding.gyp

#Automagically determine arch and replace it in hash values and links
COPY determine_arch.sh /determine_arch.sh
RUN chmod +x determine_arch.sh && \
    ./determine_arch.sh

WORKDIR /shiny-server/tmp/

# Install node for rshiny. Currently only --unsafe-perm works (see https://github.com/npm/npm/issues/3497) 
RUN PYTHON=`which python` && \
    mkdir ../build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DPYTHON="$PYTHON" ../ && \
    make -j4 && \
    ../external/node/install-node.sh && \
    PATH=$PATH:/shiny-server/ext/node/bin/ && \
    ../bin/node ../ext/node/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js configure && \
    ../bin/node ../ext/node/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js --python="$PYTHON" rebuild && \
    ../bin/npm --python="${PYTHON}" install --no-optional && \
    ../bin/npm --python="${PYTHON}" install --no-optional --unsafe-perm && \
    ../bin/npm --python="${PYTHON}" rebuild && \
    make -j4 install
    
###########################
# Production image
###########################
FROM debian:buster-20221219
# Copy artefacts from builder image
COPY --from=builder /usr/local/shiny-server /usr/local/shiny-server

WORKDIR /
RUN useradd -r -m shiny
RUN ln -s /usr/local/shiny-server/bin/shiny-server /usr/bin/shiny-server

#Create folder structure and set permissions
RUN mkdir -p        /var/log/shiny-server && \
    chown shiny     /var/log/shiny-server && \
    chmod -R 777    /var/log/shiny-server && \
    mkdir -p        /srv/shiny-server     && \
    chmod -R 777    /srv/shiny-server     && \
    mkdir -p        /var/lib/shiny-server && \
    chmod -R 777    /var/lib/shiny-server && \
    mkdir -p        /etc/shiny-server     && \
    chmod -R 777    /srv/shiny-server

#Shiny server configuration
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

#Init file for installing R-packages from host
COPY init.sh /etc/shiny-server/init.sh
RUN chmod 777 /etc/shiny-server/init.sh

RUN apt-get update && apt-get install -y --no-install-recommends \
    gfortran libreadline6-dev libcurl4-openssl-dev ca-certificates \
    libcairo2-dev xvfb libx11-dev libxt-dev libpng-dev \
    libjpeg-dev libbz2-dev libzstd-dev liblzma-dev libatomic1 \
    libgomp1 libpcre2-8-0 libssl-dev libxml2-dev g++ make && \
    rm -rf /var/lib/apt/lists/*

#Preload hello world project
COPY hello/* /srv/shiny-server/hello/

ENTRYPOINT ["/etc/shiny-server/init.sh"]

echo -e "\nInstall shiny server, done!"