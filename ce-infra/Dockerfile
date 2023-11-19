ARG NODE_VERSION=20-bookworm-slim
FROM node:${NODE_VERSION} as build 

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    zsh git build-essential \
    make file python3 python3-pip dumb-init \
    curl ca-certificates

ARG COMPILER_EXPLORER_VERSION="gh-9590"
ARG INFRA_VERSION="main"
RUN git clone -b ${INFRA_VERSION} --depth 1 https://github.com/compiler-explorer/infra.git /usr/src/infra
WORKDIR /usr/src/infra
RUN mkdir -p /opt/compiler-explorer
RUN make ce

RUN mkdir -p /usr/src/compiler-explorer
WORKDIR /usr/src/compiler-explorer
RUN git clone --branch ${COMPILER_EXPLORER_VERSION} --depth 1 https://github.com/compiler-explorer/compiler-explorer.git /usr/src/compiler-explorer

RUN make prebuild

ENTRYPOINT zsh
