FROM ghcr.io/superiorbo/alpine:latest AS base
LABEL MAINTAINER=chobon@aliyun.com
ENV NODE_VERSION 17.7.1

WORKDIR /home

RUN apk add --no-cache --virtual .build-deps-full curl gcc g++ python3 make linux-headers  && \
    curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" && \
    tar -xf "node-v$NODE_VERSION.tar.xz" && \
    cd "node-v$NODE_VERSION" && \
    ./configure && \
    make -j$(getconf _NPROCESSORS_ONLN) && \
    make install && \
    apk del .build-deps-full && \
    cd .. && \
    rm -Rf "node-v$NODE_VERSION" && \
    rm "node-v$NODE_VERSION.tar.xz"

CMD [ "node" ]